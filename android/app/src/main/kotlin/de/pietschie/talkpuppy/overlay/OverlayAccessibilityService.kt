package de.pietschie.talkpuppy.overlay

import android.Manifest
import android.accessibilityservice.AccessibilityService
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.os.Handler
import android.os.Looper
import android.view.accessibility.AccessibilityEvent
import android.widget.Toast
import de.pietschie.talkpuppy.MainActivity
import de.pietschie.talkpuppy.R
import java.util.UUID

/**
 * The floating record button. Runs as an accessibility service because
 * that is what allows an overlay over every app without extra permissions
 * and inserting the text at the cursor ([TextInserter]). It listens only to
 * window changes, to hide the button over Talkpuppy itself.
 *
 * One dictation at a time: tap → foreground service (microphone) → the
 * overlay Flutter engine records and transcribes → the text is inserted
 * into the focused field (clipboard as the last resort). All callbacks run
 * on the main thread.
 */
class OverlayAccessibilityService : AccessibilityService(), OverlayButtonView.Listener {
    private val handler = Handler(Looper.getMainLooper())
    private lateinit var button: OverlayButtonView
    private lateinit var window: OverlayWindowController
    private lateinit var engine: OverlayEngineHost
    private lateinit var inserter: TextInserter
    private lateinit var dismissTarget: DismissTarget
    private lateinit var flutterPrefs: SharedPreferences

    private var state = OverlayState.IDLE
    private var sessionId: String? = null

    /** Package of the app in front, to hide the button over Talkpuppy. */
    private var foregroundPackage: String? = null

    private val prefsListener = SharedPreferences.OnSharedPreferenceChangeListener { _, key ->
        if (key == KEY_OVERLAY_ENABLED) updateVisibility()
    }
    private val backToIdle = Runnable { setState(OverlayState.IDLE) }
    private val destroyEngine = Runnable { if (sessionId == null) engine.destroy() }
    private val transcriptionTimeout = Runnable {
        if (sessionId != null && state == OverlayState.TRANSCRIBING) {
            endSession(cancel = true)
            engine.destroy()
            showResult(OverlayState.ERROR, R.string.overlay_error_transcription)
        }
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
        button = OverlayButtonView(this, this)
        window = OverlayWindowController(this, button)
        engine = OverlayEngineHost(this, ::onEngineMessage)
        inserter = AndroidTextInserter.create(this)
        dismissTarget = DismissTarget(this)
        // Written by the app's shared_preferences plugin in this process, so
        // the listener fires as soon as the switch in the settings changes.
        flutterPrefs = getSharedPreferences(FLUTTER_PREFS, MODE_PRIVATE)
        flutterPrefs.registerOnSharedPreferenceChangeListener(prefsListener)
        RecognitionArbiter.onAppResumed = {
            // The app loads its own model; ours goes (after a running
            // session, the Dart side defers it).
            engine.sendIfRunning("unloadModel")
        }
        updateVisibility()
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        if (event.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return
        val pkg = event.packageName?.toString() ?: return
        // The notification shade and keyboards don't change which app is in
        // front.
        if (pkg == "com.android.systemui") return
        // Our own overlay window reports our package too; only the app's
        // activity means Talkpuppy itself is in front.
        if (pkg == packageName && event.className?.toString() != MainActivity::class.java.name) return
        foregroundPackage = pkg
        updateVisibility()
    }

    override fun onInterrupt() = Unit

    override fun onDestroy() {
        endSession(cancel = true)
        RecognitionArbiter.onAppResumed = null
        flutterPrefs.unregisterOnSharedPreferenceChangeListener(prefsListener)
        handler.removeCallbacksAndMessages(null)
        dismissTarget.hide()
        window.remove()
        engine.destroy()
        instance = null
        super.onDestroy()
    }

    private fun updateVisibility() {
        val enabled = flutterPrefs.getBoolean(KEY_OVERLAY_ENABLED, false)
        val overOwnApp = foregroundPackage == packageName
        // A running session keeps its button, so it can still be stopped.
        if (sessionId != null || (enabled && !overOwnApp)) window.show() else window.hide()
    }

    // ── Button gestures ─────────────────────────────────────────────────

    override fun onTap() {
        when (state) {
            OverlayState.IDLE, OverlayState.SUCCESS, OverlayState.COPIED,
            OverlayState.NO_SPEECH, OverlayState.ERROR -> startSession()
            OverlayState.PREPARING, OverlayState.RECORDING -> stopSession()
            OverlayState.TRANSCRIBING -> Unit
        }
    }

    override fun onLongPress() {
        if (state == OverlayState.PREPARING || state == OverlayState.RECORDING) {
            endSession(cancel = true)
            setState(OverlayState.IDLE)
        }
    }

    override fun onDragStart() = dismissTarget.show()

    override fun onDrag(dx: Float, dy: Float) {
        window.moveBy(dx, dy)
        val (x, y) = window.center()
        dismissTarget.isNear(x, y)
    }

    override fun onDragEnd() {
        val (x, y) = window.center()
        val dismiss = dismissTarget.isNear(x, y)
        dismissTarget.hide()
        if (dismiss) closeOverlay() else window.settle()
    }

    /** Dropped on the ✕: drop any dictation and hide until the app shows it again. */
    private fun closeOverlay() {
        endSession(cancel = true)
        handler.removeCallbacks(backToIdle)
        setState(OverlayState.IDLE)
        flutterPrefs.edit().putBoolean(KEY_OVERLAY_ENABLED, false).apply()
        window.settle()
        updateVisibility()
    }

    // ── Session ─────────────────────────────────────────────────────────

    private fun startSession() {
        handler.removeCallbacks(backToIdle)
        handler.removeCallbacks(destroyEngine)
        if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            showResult(OverlayState.ERROR, R.string.overlay_error_microphone)
            return
        }
        sessionId = UUID.randomUUID().toString()
        RecognitionArbiter.overlaySessionStarted()
        setState(OverlayState.PREPARING)
        try {
            // Recording only starts once the service is in the foreground
            // (onForegroundStarted); before that Android hands out silence.
            DictationForegroundService.start(this)
        } catch (e: Exception) {
            onForegroundRefused(e)
        }
    }

    /** Called by [DictationForegroundService] once it runs in the foreground. */
    fun onForegroundStarted() {
        val id = sessionId ?: return
        engine.send("startSession", mapOf("sessionId" to id))
    }

    fun onForegroundRefused(@Suppress("UNUSED_PARAMETER") error: Exception) {
        if (sessionId == null) return
        endSession(cancel = true)
        showResult(OverlayState.ERROR, R.string.overlay_error_background)
    }

    fun stopFromNotification() = stopSession()

    private fun stopSession() {
        val id = sessionId ?: return
        when (state) {
            // Nothing recorded yet (microphone/engine still starting).
            OverlayState.PREPARING -> {
                endSession(cancel = true)
                setState(OverlayState.IDLE)
            }
            OverlayState.RECORDING -> {
                setState(OverlayState.TRANSCRIBING)
                engine.send("stopSession", mapOf("sessionId" to id))
                // If the engine died, don't leave the button spinning.
                handler.postDelayed(transcriptionTimeout, TRANSCRIPTION_TIMEOUT_MS)
            }
            else -> Unit
        }
    }

    private fun onEngineMessage(method: String, args: Map<String, Any?>) {
        if (args["sessionId"] != sessionId) return // late message of an old session
        when (method) {
            "sessionState" -> when (args["state"]) {
                "recording" -> if (state == OverlayState.PREPARING) setState(OverlayState.RECORDING)
                "transcribing" -> setState(OverlayState.TRANSCRIBING)
            }
            "amplitude" -> button.level = (args["level"] as? Double)?.toFloat() ?: 0f
            "result" -> {
                val text = (args["text"] as? String).orEmpty().trim()
                endSession(cancel = false)
                if (text.isEmpty()) {
                    showResult(OverlayState.NO_SPEECH, R.string.overlay_no_speech)
                } else {
                    deliver(text)
                }
            }
            "error" -> {
                endSession(cancel = false)
                val message = when (args["kind"]) {
                    "noModel" -> R.string.overlay_error_no_model
                    "modelLoad" -> R.string.overlay_error_model_load
                    "recorderStart", "recorderStop" -> R.string.overlay_error_microphone
                    else -> R.string.overlay_error_transcription
                }
                showResult(OverlayState.ERROR, message)
            }
        }
    }

    private fun deliver(
        text: String,
        using: TextInserter = inserter,
        onOutcome: (TextInserter.Outcome) -> Unit = {},
    ) {
        using.insert(text) { outcome ->
            when (outcome) {
                // Success needs no toast; the check mark says it.
                TextInserter.Outcome.INSERTED -> showResult(OverlayState.SUCCESS, null)
                TextInserter.Outcome.COPIED -> showResult(OverlayState.COPIED, R.string.overlay_copied)
            }
            onOutcome(outcome)
        }
    }

    /**
     * Inserts [text] as if it had just been dictated. Only reachable from
     * debug builds (src/debug), to test insertion on devices without a
     * microphone.
     */
    internal fun insertForTesting(
        text: String,
        useKeyboard: Boolean,
        onOutcome: (TextInserter.Outcome) -> Unit,
    ) = deliver(
        text,
        if (useKeyboard) inserter else AndroidTextInserter.create(this, useKeyboard = false),
        onOutcome,
    )

    /** Ends the session on the native side; [cancel] also tells Dart to drop it. */
    private fun endSession(cancel: Boolean) {
        val id = sessionId ?: return
        if (cancel) engine.sendIfRunning("cancelSession", mapOf("sessionId" to id))
        handler.removeCallbacks(transcriptionTimeout)
        sessionId = null
        DictationForegroundService.stop(this)
        RecognitionArbiter.overlaySessionEnded()
        // The engine (tens of MB even without a model) goes after a while.
        handler.postDelayed(destroyEngine, ENGINE_IDLE_MS)
        updateVisibility()
    }

    private fun showResult(result: OverlayState, message: Int?) {
        setState(result)
        if (message != null) Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
        handler.postDelayed(backToIdle, RESULT_SHOWN_MS)
    }

    private fun setState(newState: OverlayState) {
        state = newState
        button.state = newState
    }

    companion object {
        /** The running service, for [DictationForegroundService] callbacks. */
        var instance: OverlayAccessibilityService? = null
            private set

        private const val FLUTTER_PREFS = "FlutterSharedPreferences"
        private const val KEY_OVERLAY_ENABLED = "flutter.overlayEnabled"
        private const val RESULT_SHOWN_MS = 1800L
        private const val ENGINE_IDLE_MS = 10 * 60 * 1000L
        private const val TRANSCRIPTION_TIMEOUT_MS = 10 * 60 * 1000L
    }
}

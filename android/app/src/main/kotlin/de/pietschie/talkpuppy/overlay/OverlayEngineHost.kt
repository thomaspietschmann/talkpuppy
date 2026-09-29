package de.pietschie.talkpuppy.overlay

import android.content.Context
import android.os.Handler
import android.os.Looper
import de.pietschie.talkpuppy.TalkpuppyEngine
import io.flutter.plugin.common.MethodChannel

/**
 * The floating button's line to the app's Dart side (`talkpuppy/overlay`
 * channel on the shared [TalkpuppyEngine]), which records and transcribes
 * with the app's already loaded model. Commands wait until the Dart side is
 * set up: it announces itself with `ready` when it starts after us, and
 * answers a `hello` when it was running before. Main thread only.
 */
class OverlayEngineHost(
    private val context: Context,
    private val onMessage: (method: String, args: Map<String, Any?>) -> Unit,
) {
    private val handler = Handler(Looper.getMainLooper())
    private var channel: MethodChannel? = null
    private var ready = false
    private val pending = mutableListOf<Pair<String, Map<String, Any?>>>()

    fun send(method: String, args: Map<String, Any?> = emptyMap()) {
        ensureChannel()
        if (ready) channel?.invokeMethod(method, args) else pending.add(method to args)
    }

    private fun ensureChannel() {
        if (channel != null) return
        val engine = TalkpuppyEngine.get(context)
        val methodChannel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "ready") {
                markReady()
            } else {
                @Suppress("UNCHECKED_CAST")
                onMessage(call.method, (call.arguments as? Map<String, Any?>) ?: emptyMap())
            }
            result.success(null)
        }
        channel = methodChannel
        hello()
    }

    /** Asks a Dart side that started before us; retried until it answers. */
    private fun hello() {
        if (ready) return
        channel?.invokeMethod("hello", null, object : MethodChannel.Result {
            override fun success(result: Any?) = markReady()
            override fun error(code: String, message: String?, details: Any?) = retry()
            override fun notImplemented() = retry()
        })
    }

    private fun retry() {
        handler.postDelayed({ hello() }, HELLO_RETRY_MS)
    }

    private fun markReady() {
        if (ready) return
        ready = true
        val queued = pending.toList()
        pending.clear()
        queued.forEach { (method, args) -> channel?.invokeMethod(method, args) }
    }

    /** Detaches from the engine (the engine itself lives on). */
    fun close() {
        handler.removeCallbacksAndMessages(null)
        channel?.setMethodCallHandler(null)
        channel = null
        ready = false
        pending.clear()
    }

    companion object {
        private const val CHANNEL = "talkpuppy/overlay"
        private const val HELLO_RETRY_MS = 300L
    }
}

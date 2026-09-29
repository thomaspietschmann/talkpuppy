package de.pietschie.talkpuppy.overlay

import android.content.Context
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

/**
 * Owns the second, UI-less Flutter engine (Dart entry point `overlayMain`)
 * that records and transcribes for the floating button. Started lazily on
 * the first tap; commands sent before its Dart side reports `ready` are
 * queued. Main thread only.
 */
class OverlayEngineHost(
    private val context: Context,
    private val onMessage: (method: String, args: Map<String, Any?>) -> Unit,
) {
    private var engine: FlutterEngine? = null
    private var channel: MethodChannel? = null
    private var ready = false
    private val pending = mutableListOf<Pair<String, Map<String, Any?>>>()

    val isRunning: Boolean get() = engine != null

    fun send(method: String, args: Map<String, Any?> = emptyMap()) {
        ensureEngine()
        if (ready) channel?.invokeMethod(method, args) else pending.add(method to args)
    }

    /** Like [send], but doesn't start the engine just for this. */
    fun sendIfRunning(method: String, args: Map<String, Any?> = emptyMap()) {
        if (engine != null) send(method, args)
    }

    private fun ensureEngine() {
        if (engine != null) return
        val flutterEngine = FlutterEngine(context.applicationContext)
        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "ready") {
                ready = true
                val queued = pending.toList()
                pending.clear()
                queued.forEach { (method, args) -> methodChannel.invokeMethod(method, args) }
            } else {
                @Suppress("UNCHECKED_CAST")
                onMessage(call.method, (call.arguments as? Map<String, Any?>) ?: emptyMap())
            }
            result.success(null)
        }
        val bundlePath = FlutterInjector.instance().flutterLoader().findAppBundlePath()
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(bundlePath, "overlayMain"),
        )
        engine = flutterEngine
        channel = methodChannel
    }

    fun destroy() {
        channel?.setMethodCallHandler(null)
        engine?.destroy()
        engine = null
        channel = null
        ready = false
        pending.clear()
    }

    companion object {
        private const val CHANNEL = "talkpuppy/overlay"
    }
}

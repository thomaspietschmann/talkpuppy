package de.pietschie.talkpuppy

import android.app.ActivityManager
import android.content.Context
import android.os.StatFs
import de.pietschie.talkpuppy.overlay.RecognitionArbiter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val deviceInfoChannel = "talkpuppy/device_info"
    private val clipboardChannel = "talkpuppy/clipboard"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, deviceInfoChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                // Used to pick a sane default model during onboarding; there's
                // no cross-platform Dart API for total device RAM.
                "totalRamBytes" -> {
                    val activityManager =
                        getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                    val memoryInfo = ActivityManager.MemoryInfo()
                    activityManager.getMemoryInfo(memoryInfo)
                    result.success(memoryInfo.totalMem)
                }
                // Checked before a model download.
                "freeDiskBytes" -> {
                    val path = call.argument<String>("path") ?: filesDir.path
                    try {
                        result.success(StatFs(path).availableBytes)
                    } catch (e: IllegalArgumentException) {
                        result.error("STATFS_FAILED", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }

        // Transcripts can be private; see SensitiveClip.
        MethodChannel(messenger, clipboardChannel).setMethodCallHandler { call, result ->
            if (call.method == "copySensitive") {
                SensitiveClip.copy(this, call.argument<String>("text") ?: "")
                result.success(null)
            } else {
                result.notImplemented()
            }
        }

        overlaySetup = OverlaySetupChannel(this, messenger)
    }

    private var overlaySetup: OverlaySetupChannel? = null

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        overlaySetup?.onRequestPermissionsResult(requestCode)
    }

    override fun onResume() {
        super.onResume()
        // The app wants its model back; the floating button frees its own.
        RecognitionArbiter.appResumed()
    }
}

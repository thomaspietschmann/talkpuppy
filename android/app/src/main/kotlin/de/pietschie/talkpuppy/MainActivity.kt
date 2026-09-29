package de.pietschie.talkpuppy

import android.app.ActivityManager
import android.content.ClipData
import android.content.ClipDescription
import android.content.ClipboardManager
import android.content.Context
import android.os.Build
import android.os.PersistableBundle
import android.os.StatFs
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

        // Transcripts can be private: mark them sensitive so Android 13+
        // doesn't show them in the clipboard preview overlay and clipboard
        // sync tools skip them.
        MethodChannel(messenger, clipboardChannel).setMethodCallHandler { call, result ->
            if (call.method == "copySensitive") {
                val text = call.argument<String>("text") ?: ""
                val clip = ClipData.newPlainText("Talkpuppy", text)
                clip.description.extras = PersistableBundle().apply {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        putBoolean(ClipDescription.EXTRA_IS_SENSITIVE, true)
                    } else {
                        putBoolean("android.content.extra.IS_SENSITIVE", true)
                    }
                }
                val clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
                clipboard.setPrimaryClip(clip)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}

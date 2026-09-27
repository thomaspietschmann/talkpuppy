package de.pietschie.talkpuppy

import android.app.ActivityManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val deviceInfoChannel = "talkpuppy/device_info"

    // Used to pick a sane default model during onboarding; there's no
    // cross-platform Dart API for total device RAM.
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, deviceInfoChannel)
            .setMethodCallHandler { call, result ->
                if (call.method == "totalRamBytes") {
                    val activityManager =
                        getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                    val memoryInfo = ActivityManager.MemoryInfo()
                    activityManager.getMemoryInfo(memoryInfo)
                    result.success(memoryInfo.totalMem)
                } else {
                    result.notImplemented()
                }
            }
    }
}

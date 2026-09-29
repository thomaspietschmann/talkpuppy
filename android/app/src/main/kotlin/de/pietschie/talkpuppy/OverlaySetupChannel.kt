package de.pietschie.talkpuppy

import android.Manifest
import android.app.Activity
import android.content.ComponentName
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import de.pietschie.talkpuppy.overlay.OverlayAccessibilityService
import de.pietschie.talkpuppy.overlay.RecognitionArbiter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/**
 * The app's `talkpuppy/overlay_setup` channel: status of the floating
 * button's accessibility service, system settings, notification permission
 * and waiting for the overlay to release the model.
 */
class OverlaySetupChannel(private val activity: Activity, messenger: BinaryMessenger) {
    init {
        MethodChannel(messenger, "talkpuppy/overlay_setup").setMethodCallHandler { call, result ->
            when (call.method) {
                "isServiceEnabled" -> result.success(isServiceEnabled())
                "openAccessibilitySettings" -> {
                    activity.startActivity(
                        Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
                    )
                    result.success(null)
                }
                "requestNotificationPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
                        activity.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) !=
                        PackageManager.PERMISSION_GRANTED
                    ) {
                        // Answered in onRequestPermissionsResult, so the caller
                        // can wait for the dialog before leaving the app.
                        pendingNotificationResult?.success(null)
                        pendingNotificationResult = result
                        activity.requestPermissions(
                            arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                            REQUEST_NOTIFICATIONS,
                        )
                    } else {
                        result.success(null)
                    }
                }
                "waitUntilOverlayIdle" -> RecognitionArbiter.awaitOverlayIdle { result.success(null) }
                // "Minimize and show overlay": the app goes to the background,
                // where the floating button takes over.
                "minimizeApp" -> {
                    activity.moveTaskToBack(true)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private var pendingNotificationResult: MethodChannel.Result? = null

    /** Forwarded from [MainActivity.onRequestPermissionsResult]. */
    fun onRequestPermissionsResult(requestCode: Int) {
        if (requestCode != REQUEST_NOTIFICATIONS) return
        pendingNotificationResult?.success(null)
        pendingNotificationResult = null
    }

    private fun isServiceEnabled(): Boolean {
        val enabled = Settings.Secure.getString(
            activity.contentResolver,
            Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES,
        ) ?: return false
        val ours = ComponentName(activity, OverlayAccessibilityService::class.java)
        return enabled.split(':').any { ComponentName.unflattenFromString(it) == ours }
    }

    companion object {
        private const val REQUEST_NOTIFICATIONS = 4711
    }
}

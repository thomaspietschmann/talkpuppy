package de.pietschie.talkpuppy

import android.Manifest
import android.app.Activity
import android.content.ComponentName
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import de.pietschie.talkpuppy.overlay.OverlayAccessibilityService
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/**
 * The app's `talkpuppy/overlay_setup` channel: status of the floating
 * button's accessibility service, its system shortcut, system settings,
 * notification permission and minimizing.
 */
class OverlaySetupChannel(private val activity: Activity, messenger: BinaryMessenger) {
    init {
        MethodChannel(messenger, "talkpuppy/overlay_setup").setMethodCallHandler { call, result ->
            when (call.method) {
                "isServiceEnabled" -> result.success(isServiceEnabled())
                "isShortcutEnabled" -> result.success(isShortcutEnabled())
                "openServiceSettings" -> {
                    openServiceSettings()
                    result.success(null)
                }
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

    private val ourService get() = ComponentName(activity, OverlayAccessibilityService::class.java)

    /**
     * Whether an accessibility shortcut targets our service. Android (and
     * One UI) offer a "Shortcut" under every accessibility service; turned
     * on, the system pins our app icon to the screen edge, which looks like
     * the floating button but isn't. The keys are hidden but readable
     * settings; any we can't read count as off.
     */
    private fun isShortcutEnabled(): Boolean = SHORTCUT_KEYS.any { key ->
        val value = try {
            Settings.Secure.getString(activity.contentResolver, key)
        } catch (e: SecurityException) {
            android.util.Log.w("TalkpuppySetup", "can't read $key: ${e.message}")
            null
        } ?: return@any false
        value.split(':').any { targetsUs(it) }
    }

    private fun targetsUs(target: String): Boolean {
        if (target.isBlank()) return false
        val name = ComponentName.unflattenFromString(target) ?: return false
        return name == ourService
    }

    /** Talkpuppy's own page in the accessibility settings, where the shortcut switch is. */
    private fun openServiceSettings() {
        val details = Intent(ACTION_ACCESSIBILITY_DETAILS_SETTINGS)
            .putExtra(Intent.EXTRA_COMPONENT_NAME, ourService.flattenToString())
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        try {
            activity.startActivity(details)
        } catch (e: Exception) {
            activity.startActivity(
                Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
            )
        }
    }

    private fun isServiceEnabled(): Boolean {
        val enabled = Settings.Secure.getString(
            activity.contentResolver,
            Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES,
        ) ?: return false
        return enabled.split(':').any { targetsUs(it) }
    }

    companion object {
        private const val REQUEST_NOTIFICATIONS = 4711
        private const val ACTION_ACCESSIBILITY_DETAILS_SETTINGS =
            "android.settings.ACCESSIBILITY_DETAILS_SETTINGS"

        /** Floating/navigation-bar button, volume keys, gesture, Quick Settings. */
        private val SHORTCUT_KEYS = listOf(
            "accessibility_button_targets",
            "accessibility_shortcut_target_service",
            "accessibility_gesture_targets",
            "accessibility_qs_targets",
        )
    }
}

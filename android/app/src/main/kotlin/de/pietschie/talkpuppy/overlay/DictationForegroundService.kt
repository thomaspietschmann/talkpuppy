package de.pietschie.talkpuppy.overlay

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.graphics.drawable.Icon
import android.os.Build
import android.os.IBinder
import de.pietschie.talkpuppy.MainActivity
import de.pietschie.talkpuppy.R

/**
 * Holds the microphone while a floating-button dictation runs in the
 * background: Android only lets apps record from the background inside a
 * foreground service of type `microphone`. Started by the accessibility
 * service on tap (allowed because the button is a visible overlay window),
 * stopped when the session ends. Its notification offers Stop.
 */
class DictationForegroundService : Service() {
    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            OverlayAccessibilityService.instance?.stopFromNotification()
            return START_NOT_STICKY
        }
        try {
            val notification = buildNotification()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                startForeground(
                    NOTIFICATION_ID,
                    notification,
                    ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE,
                )
            } else {
                startForeground(NOTIFICATION_ID, notification)
            }
            OverlayAccessibilityService.instance?.onForegroundStarted()
        } catch (e: Exception) {
            // ForegroundServiceStartNotAllowedException / SecurityException:
            // the system (or an OEM tweak) refused background mic access.
            OverlayAccessibilityService.instance?.onForegroundRefused(e)
            stopSelf()
        }
        return START_NOT_STICKY
    }

    private fun buildNotification(): Notification {
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            manager.createNotificationChannel(
                NotificationChannel(
                    CHANNEL_ID,
                    getString(R.string.overlay_notification_channel),
                    NotificationManager.IMPORTANCE_LOW,
                ),
            )
        }
        val stop = PendingIntent.getService(
            this,
            0,
            Intent(this, DictationForegroundService::class.java).setAction(ACTION_STOP),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )
        val open = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_IMMUTABLE,
        )
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, CHANNEL_ID)
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(this)
        }
        return builder
            .setSmallIcon(R.drawable.ic_notification_mic)
            .setContentTitle(getString(R.string.overlay_notification_title))
            .setContentText(getString(R.string.overlay_notification_listening))
            .setOngoing(true)
            .setContentIntent(open)
            .addAction(
                Notification.Action.Builder(
                    Icon.createWithResource(this, R.drawable.ic_notification_mic),
                    getString(R.string.overlay_notification_stop),
                    stop,
                ).build(),
            )
            .build()
    }

    companion object {
        private const val CHANNEL_ID = "talkpuppy_dictation"
        private const val NOTIFICATION_ID = 1
        private const val ACTION_STOP = "de.pietschie.talkpuppy.overlay.STOP"

        fun start(context: Context) {
            val intent = Intent(context, DictationForegroundService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, DictationForegroundService::class.java))
        }
    }
}

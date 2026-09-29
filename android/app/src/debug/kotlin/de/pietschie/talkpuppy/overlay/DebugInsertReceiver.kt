package de.pietschie.talkpuppy.overlay

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

/**
 * Debug builds only: lets insertion be tested without a microphone.
 *
 *     adb shell am broadcast -n de.pietschie.talkpuppy/.overlay.DebugInsertReceiver --es text "Hallo"
 *
 * `--ez keyboard false` skips the Android 13+ keyboard path, to test the
 * fallback older Android versions use.
 *
 * The outcome is logged under the tag TalkpuppyInsert.
 */
class DebugInsertReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val text = intent.getStringExtra("text") ?: return
        val service = OverlayAccessibilityService.instance
        if (service == null) {
            Log.i(TAG, "outcome=NO_SERVICE")
            return
        }
        val pending = goAsync()
        val useKeyboard = intent.getBooleanExtra("keyboard", true)
        service.insertForTesting(text, useKeyboard) { outcome ->
            Log.i(TAG, "outcome=$outcome")
            pending.finish()
        }
    }

    companion object {
        private const val TAG = "TalkpuppyInsert"
    }
}

package de.pietschie.talkpuppy

import android.content.ClipData
import android.content.ClipDescription
import android.content.ClipboardManager
import android.content.Context
import android.os.Build
import android.os.PersistableBundle

/**
 * Transcripts can be private: mark them sensitive so Android 13+ doesn't
 * show them in the clipboard preview overlay and clipboard sync tools
 * skip them. Used by the app and by the floating button.
 */
object SensitiveClip {
    fun copy(context: Context, text: String) {
        val clip = ClipData.newPlainText("Talkpuppy", text)
        clip.description.extras = PersistableBundle().apply {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                putBoolean(ClipDescription.EXTRA_IS_SENSITIVE, true)
            } else {
                putBoolean("android.content.extra.IS_SENSITIVE", true)
            }
        }
        val clipboard = context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        clipboard.setPrimaryClip(clip)
    }
}

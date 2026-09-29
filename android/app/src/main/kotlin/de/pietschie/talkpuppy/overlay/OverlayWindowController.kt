package de.pietschie.talkpuppy.overlay

import android.content.Context
import android.graphics.PixelFormat
import android.os.Build
import android.view.Gravity
import android.view.View
import android.view.WindowManager

/**
 * Puts the [OverlayButtonView] on screen as an accessibility overlay (no
 * "display over other apps" permission needed) that never takes focus, so
 * the text field the user tapped keeps its cursor. The position is kept as
 * screen side + fraction of the height, which survives rotation.
 */
class OverlayWindowController(
    private val context: Context,
    private val button: OverlayButtonView,
) {
    private val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
    private val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
    private val size = (OverlayButtonView.SIZE_DP * context.resources.displayMetrics.density).toInt()

    /**
     * Gap to the screen edge. Right at the edge, system handles take the
     * touches: Samsung's Edge Panel handle (right edge, mid height) and the
     * back gesture area.
     */
    private val edgeMargin = (EDGE_MARGIN_DP * context.resources.displayMetrics.density).toInt()
    private val params = WindowManager.LayoutParams(
        size,
        size,
        WindowManager.LayoutParams.TYPE_ACCESSIBILITY_OVERLAY,
        WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
            WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL or
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
        PixelFormat.TRANSLUCENT,
    ).apply {
        gravity = Gravity.TOP or Gravity.START
    }
    private var added = false

    fun show() {
        if (!added) {
            restorePosition()
            windowManager.addView(button, params)
            added = true
        }
        button.visibility = View.VISIBLE
    }

    fun hide() {
        if (added) button.visibility = View.GONE
    }

    fun remove() {
        if (added) {
            windowManager.removeView(button)
            added = false
        }
    }

    /**
     * After a rotation (or a foldable unfolding) the old pixel position may
     * be off screen: place the button again from the saved side and height
     * fraction.
     */
    fun reposition() {
        if (!added) return
        restorePosition()
        windowManager.updateViewLayout(button, params)
    }

    fun moveBy(dx: Float, dy: Float) {
        if (!added) return
        params.x += dx.toInt()
        params.y += dy.toInt()
        windowManager.updateViewLayout(button, params)
    }

    /** Centre of the button in screen coordinates. */
    fun center(): Pair<Float, Float> = (params.x + size / 2f) to (params.y + size / 2f)

    /** Snaps to the nearer screen edge and remembers the position. */
    fun settle() {
        if (!added) return
        val (width, height) = screenSize()
        val right = params.x + size / 2 > width / 2
        params.x = if (right) width - size - edgeMargin else edgeMargin
        params.y = params.y.coerceIn(0, (height - size).coerceAtLeast(0))
        windowManager.updateViewLayout(button, params)
        prefs.edit()
            .putBoolean(KEY_RIGHT, right)
            .putFloat(KEY_Y, params.y.toFloat() / height.coerceAtLeast(1))
            .apply()
    }

    private fun restorePosition() {
        val (width, height) = screenSize()
        val right = prefs.getBoolean(KEY_RIGHT, true)
        params.x = if (right) width - size - edgeMargin else edgeMargin
        // Default below the middle: Samsung's Edge Panel handle sits at mid
        // height on the right.
        params.y = (prefs.getFloat(KEY_Y, DEFAULT_Y) * height).toInt()
            .coerceIn(0, (height - size).coerceAtLeast(0))
    }

    private fun screenSize(): Pair<Int, Int> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val bounds = windowManager.currentWindowMetrics.bounds
            bounds.width() to bounds.height()
        } else {
            val metrics = context.resources.displayMetrics
            metrics.widthPixels to metrics.heightPixels
        }
    }

    companion object {
        private const val PREFS = "talkpuppy_overlay"
        private const val KEY_RIGHT = "right"
        private const val KEY_Y = "y"
        private const val DEFAULT_Y = 0.68f
        private const val EDGE_MARGIN_DP = 20
    }
}

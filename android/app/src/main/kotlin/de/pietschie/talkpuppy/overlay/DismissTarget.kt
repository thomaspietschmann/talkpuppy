package de.pietschie.talkpuppy.overlay

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.PixelFormat
import android.os.Build
import android.view.Gravity
import android.view.View
import android.view.WindowManager

/**
 * The ✕ at the bottom of the screen while the floating button is dragged:
 * dropping the button on it closes the overlay. Doesn't take touches.
 */
class DismissTarget(private val context: Context) {
    private val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
    private val density = context.resources.displayMetrics.density
    private val size = (72 * density).toInt()
    private val bottomMargin = (72 * density).toInt()
    private val view = TargetView(context)
    private val params = WindowManager.LayoutParams(
        size,
        size,
        WindowManager.LayoutParams.TYPE_ACCESSIBILITY_OVERLAY,
        WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
            WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE or
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
        PixelFormat.TRANSLUCENT,
    ).apply {
        gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
        y = bottomMargin
    }
    private var added = false

    fun show() {
        view.active = false
        if (!added) {
            windowManager.addView(view, params)
            added = true
        }
    }

    fun hide() {
        if (added) {
            windowManager.removeView(view)
            added = false
        }
    }

    /** Whether a point (screen coordinates) is close enough to drop on. */
    fun isNear(x: Float, y: Float): Boolean {
        if (!added) return false
        val (width, height) = screenSize()
        val cx = width / 2f
        val cy = height - bottomMargin - size / 2f
        val dx = x - cx
        val dy = y - cy
        val near = dx * dx + dy * dy < (size * size).toFloat()
        view.active = near
        return near
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

    @SuppressLint("ViewConstructor")
    private class TargetView(context: Context) : View(context) {
        var active = false
            set(value) {
                if (field != value) {
                    field = value
                    if (value) performHapticFeedback(android.view.HapticFeedbackConstants.CLOCK_TICK)
                    invalidate()
                }
            }
        private val density = resources.displayMetrics.density
        private val fill = Paint(Paint.ANTI_ALIAS_FLAG)
        private val cross = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.WHITE
            strokeWidth = 3 * density
            strokeCap = Paint.Cap.ROUND
        }

        override fun onDraw(canvas: Canvas) {
            val cx = width / 2f
            val cy = height / 2f
            val r = (if (active) 34 else 28) * density
            fill.color = if (active) Color.rgb(176, 0, 32) else Color.argb(200, 40, 36, 52)
            canvas.drawCircle(cx, cy, r, fill)
            val a = 9 * density
            canvas.drawLine(cx - a, cy - a, cx + a, cy + a, cross)
            canvas.drawLine(cx - a, cy + a, cx + a, cy - a, cross)
        }
    }
}

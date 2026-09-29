package de.pietschie.talkpuppy.overlay

import android.animation.ValueAnimator
import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.RectF
import android.graphics.drawable.Drawable
import android.view.HapticFeedbackConstants
import android.view.MotionEvent
import android.view.View
import android.view.ViewConfiguration
import android.view.animation.LinearInterpolator
import de.pietschie.talkpuppy.R

/** What the floating button currently shows. */
enum class OverlayState { IDLE, PREPARING, RECORDING, TRANSCRIBING, SUCCESS, COPIED, NO_SPEECH, ERROR }

/**
 * The floating record button: a circle whose colour and icon follow
 * [state], with a ring that grows with the microphone level while
 * recording and a spinner while preparing/transcribing.
 *
 * Gestures: tap; drag (after moving past the touch slop) to reposition or
 * onto the ✕ to close; hold still for [LONG_PRESS_MS] to cancel a
 * recording.
 */
@SuppressLint("ViewConstructor")
class OverlayButtonView(
    context: Context,
    private val listener: Listener,
) : View(context) {
    interface Listener {
        fun onTap()
        fun onLongPress()
        fun onDragStart()
        fun onDrag(dx: Float, dy: Float)
        fun onDragEnd()
    }

    var state: OverlayState = OverlayState.IDLE
        set(value) {
            if (field == value) return
            field = value
            if (value != OverlayState.RECORDING) level = 0f
            updateSpinner()
            contentDescription = context.getString(
                if (value == OverlayState.RECORDING) R.string.overlay_button_stop else R.string.overlay_button_record,
            )
            invalidate()
        }

    /**
     * Greyed out and not tappable, while Talkpuppy itself is in front (it
     * has its own record button there). Dragging still works.
     */
    var dimmed: Boolean = false
        set(value) {
            if (field == value) return
            field = value
            alpha = if (value) DIMMED_ALPHA else 1f
            invalidate()
        }

    /** Microphone level 0..1 while recording. */
    var level: Float = 0f
        set(value) {
            field = value
            if (state == OverlayState.RECORDING) invalidate()
        }

    private val density = resources.displayMetrics.density
    private val radius = 24 * density
    private val fill = Paint(Paint.ANTI_ALIAS_FLAG)
    private val ring = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        style = Paint.Style.STROKE
        strokeWidth = 3 * density
        color = Color.WHITE
    }
    private val spinnerRect = RectF()
    private var spinnerAngle = 0f
    private val spinner = ValueAnimator.ofFloat(0f, 360f).apply {
        duration = 900
        repeatCount = ValueAnimator.INFINITE
        interpolator = LinearInterpolator()
        addUpdateListener {
            spinnerAngle = it.animatedValue as Float
            invalidate()
        }
    }

    private val icons = mapOf(
        R.drawable.ic_overlay_mic to context.getDrawable(R.drawable.ic_overlay_mic)!!,
        R.drawable.ic_overlay_stop to context.getDrawable(R.drawable.ic_overlay_stop)!!,
        R.drawable.ic_overlay_check to context.getDrawable(R.drawable.ic_overlay_check)!!,
        R.drawable.ic_overlay_copy to context.getDrawable(R.drawable.ic_overlay_copy)!!,
        R.drawable.ic_overlay_error to context.getDrawable(R.drawable.ic_overlay_error)!!,
    )

    private val touchSlop = ViewConfiguration.get(context).scaledTouchSlop
    private var downX = 0f
    private var downY = 0f
    private var lastX = 0f
    private var lastY = 0f
    private var dragging = false
    private var longPressed = false
    private val longPress = Runnable {
        if (!dragging) {
            longPressed = true
            performHapticFeedback(HapticFeedbackConstants.LONG_PRESS)
            listener.onLongPress()
        }
    }

    init {
        contentDescription = context.getString(R.string.overlay_button_record)
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        // Room for the level ring around the 48 dp circle.
        val size = (SIZE_DP * density).toInt()
        setMeasuredDimension(size, size)
    }

    override fun onDraw(canvas: Canvas) {
        val cx = width / 2f
        val cy = height / 2f
        if (state == OverlayState.RECORDING && level > 0f) {
            fill.color = Color.argb((80 * level).toInt() + 40, 229, 57, 53)
            canvas.drawCircle(cx, cy, radius + level * 7 * density, fill)
        }
        fill.color = if (dimmed) Color.rgb(120, 116, 132) else colorFor(state)
        fill.alpha = if (state == OverlayState.IDLE) 225 else 255
        canvas.drawCircle(cx, cy, radius, fill)

        if (state == OverlayState.PREPARING || state == OverlayState.TRANSCRIBING) {
            val r = radius - 5 * density
            spinnerRect.set(cx - r, cy - r, cx + r, cy + r)
            canvas.drawArc(spinnerRect, spinnerAngle, 100f, false, ring)
        }

        val icon = icons.getValue(iconFor(state))
        val half = (12 * density).toInt()
        icon.setBounds(cx.toInt() - half, cy.toInt() - half, cx.toInt() + half, cy.toInt() + half)
        icon.draw(canvas)
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onTouchEvent(event: MotionEvent): Boolean {
        when (event.actionMasked) {
            MotionEvent.ACTION_DOWN -> {
                downX = event.rawX
                downY = event.rawY
                lastX = downX
                lastY = downY
                dragging = false
                longPressed = false
                postDelayed(longPress, LONG_PRESS_MS)
            }
            MotionEvent.ACTION_MOVE -> {
                if (!dragging && !longPressed &&
                    (Math.abs(event.rawX - downX) > touchSlop || Math.abs(event.rawY - downY) > touchSlop)
                ) {
                    dragging = true
                    removeCallbacks(longPress)
                    listener.onDragStart()
                }
                if (dragging) {
                    listener.onDrag(event.rawX - lastX, event.rawY - lastY)
                    lastX = event.rawX
                    lastY = event.rawY
                }
            }
            MotionEvent.ACTION_UP -> {
                removeCallbacks(longPress)
                when {
                    dragging -> listener.onDragEnd()
                    !longPressed -> {
                        performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY)
                        listener.onTap()
                    }
                }
            }
            MotionEvent.ACTION_CANCEL -> {
                removeCallbacks(longPress)
                if (dragging) listener.onDragEnd()
            }
        }
        return true
    }

    override fun onDetachedFromWindow() {
        spinner.cancel()
        removeCallbacks(longPress)
        super.onDetachedFromWindow()
    }

    private fun updateSpinner() {
        val spin = state == OverlayState.PREPARING || state == OverlayState.TRANSCRIBING
        if (spin && !spinner.isStarted) spinner.start()
        if (!spin) spinner.cancel()
    }

    private fun colorFor(state: OverlayState): Int = when (state) {
        OverlayState.IDLE -> Color.rgb(236, 45, 120) // brand magenta
        OverlayState.RECORDING -> Color.rgb(229, 57, 53)
        OverlayState.PREPARING, OverlayState.TRANSCRIBING, OverlayState.NO_SPEECH -> Color.rgb(92, 88, 112)
        OverlayState.SUCCESS -> Color.rgb(46, 125, 50)
        OverlayState.COPIED -> Color.rgb(0, 150, 170) // brand cyan, darkened for contrast
        OverlayState.ERROR -> Color.rgb(176, 0, 32)
    }

    private fun iconFor(state: OverlayState): Int = when (state) {
        OverlayState.IDLE, OverlayState.PREPARING, OverlayState.NO_SPEECH -> R.drawable.ic_overlay_mic
        OverlayState.RECORDING -> R.drawable.ic_overlay_stop
        OverlayState.TRANSCRIBING -> R.drawable.ic_overlay_mic
        OverlayState.SUCCESS -> R.drawable.ic_overlay_check
        OverlayState.COPIED -> R.drawable.ic_overlay_copy
        OverlayState.ERROR -> R.drawable.ic_overlay_error
    }

    companion object {
        const val SIZE_DP = 64
        private const val DIMMED_ALPHA = 0.45f
        private const val LONG_PRESS_MS = 600L
    }
}

package de.pietschie.talkpuppy.overlay

/**
 * Keeps at most one speech model in memory. The app (engine A) and the
 * floating button (engine B) each have their own recognizer; a model
 * loaded in one can't be used by the other, and two large models at once
 * would get the process killed. Main thread only.
 */
object RecognitionArbiter {
    /** True while a floating-button dictation runs. */
    var overlayBusy = false
        private set

    private val idleWaiters = mutableListOf<() -> Unit>()

    /** Set by the accessibility service: free the overlay's model. */
    var onAppResumed: (() -> Unit)? = null

    fun overlaySessionStarted() {
        overlayBusy = true
    }

    fun overlaySessionEnded() {
        overlayBusy = false
        val waiters = idleWaiters.toList()
        idleWaiters.clear()
        waiters.forEach { it() }
    }

    /** Runs [callback] once no dictation is running (right away if none). */
    fun awaitOverlayIdle(callback: () -> Unit) {
        if (overlayBusy) idleWaiters.add(callback) else callback()
    }

    fun appResumed() {
        onAppResumed?.invoke()
    }
}

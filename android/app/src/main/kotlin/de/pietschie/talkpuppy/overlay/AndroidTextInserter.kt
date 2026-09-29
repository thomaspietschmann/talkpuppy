package de.pietschie.talkpuppy.overlay

import android.accessibilityservice.AccessibilityService
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.accessibility.AccessibilityNodeInfo
import android.view.accessibility.AccessibilityWindowInfo
import androidx.annotation.RequiresApi
import de.pietschie.talkpuppy.SensitiveClip

/** A [TextInserter] wired to the accessibility service's real field, keyboard and clipboard. */
object AndroidTextInserter {
    /** [useKeyboard] false forces the path Android 12 and older take (tests). */
    fun create(service: AccessibilityService, useKeyboard: Boolean = true): TextInserter {
        val handler = Handler(Looper.getMainLooper())
        return TextInserter(
            keyboard = {
                if (useKeyboard && Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    ServiceKeyboard.of(service)
                } else {
                    null
                }
            },
            focusedField = { focusedField(service) },
            copyToClipboard = { SensitiveClip.copy(service, it) },
            schedule = { delay, action -> handler.postDelayed(action, delay) },
        )
    }

    private fun focusedField(service: AccessibilityService): NodeField? {
        service.rootInActiveWindow?.findFocus(AccessibilityNodeInfo.FOCUS_INPUT)?.let { return fieldWithin(it) }
        for (window in service.windows) {
            if (window.type != AccessibilityWindowInfo.TYPE_APPLICATION) continue
            window.root?.findFocus(AccessibilityNodeInfo.FOCUS_INPUT)?.let { return fieldWithin(it) }
        }
        return null
    }

    /** A field found inside a focused, non-editable container is web content. */
    private fun fieldWithin(focused: AccessibilityNodeInfo): NodeField {
        if (focused.isEditable) return NodeField(focused, isWebContent = false)
        val inner = editableWithin(focused)
        return NodeField(inner, isWebContent = inner !== focused)
    }

    /**
     * Browsers and WebViews report their whole content view as the focused
     * node; the web text field that has the cursor is a focused editable
     * node somewhere below it.
     */
    private fun editableWithin(focused: AccessibilityNodeInfo): AccessibilityNodeInfo {
        val queue = ArrayDeque<AccessibilityNodeInfo>()
        queue.add(focused)
        var visited = 0
        while (queue.isNotEmpty() && visited < MAX_NODES_SEARCHED) {
            val node = queue.removeFirst()
            visited++
            if (node.isEditable && node.isFocused) return node
            for (i in 0 until node.childCount) node.getChild(i)?.let(queue::add)
        }
        return focused
    }

    /** Bounds the search in huge pages; the focused field is usually near the top. */
    private const val MAX_NODES_SEARCHED = 3000
}

private class NodeField(
    private val node: AccessibilityNodeInfo,
    override val isWebContent: Boolean,
) : EditableField {
    override val isEditable get() = node.isEditable
    override val isPassword get() = node.isPassword
    override val text: String?
        get() = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && node.isShowingHintText) {
            ""
        } else {
            node.text?.toString()
        }
    override val selectionStart get() = node.textSelectionStart
    override val selectionEnd get() = node.textSelectionEnd

    override fun refresh() = node.refresh()

    override fun setText(value: String): Boolean {
        val args = Bundle().apply {
            putCharSequence(AccessibilityNodeInfo.ACTION_ARGUMENT_SET_TEXT_CHARSEQUENCE, value)
        }
        return node.performAction(AccessibilityNodeInfo.ACTION_SET_TEXT, args)
    }

    override fun setSelection(start: Int, end: Int): Boolean {
        val args = Bundle().apply {
            putInt(AccessibilityNodeInfo.ACTION_ARGUMENT_SELECTION_START_INT, start)
            putInt(AccessibilityNodeInfo.ACTION_ARGUMENT_SELECTION_END_INT, end)
        }
        return node.performAction(AccessibilityNodeInfo.ACTION_SET_SELECTION, args)
    }

    override fun paste() = node.performAction(AccessibilityNodeInfo.ACTION_PASTE)
}

@RequiresApi(Build.VERSION_CODES.TIRAMISU)
private class ServiceKeyboard(
    private val connection: android.accessibilityservice.InputMethod.AccessibilityInputConnection,
) : KeyboardInput {
    override fun charsAroundSelection(): Pair<Char?, Char?> {
        // The returned text is: 1 char before + the selection + 1 char
        // after; the offsets say where the selection sits in it.
        val surrounding = connection.getSurroundingText(1, 1, 0) ?: return null to null
        val text = surrounding.text
        val before = if (surrounding.selectionStart > 0) text.getOrNull(surrounding.selectionStart - 1) else null
        return before to text.getOrNull(surrounding.selectionEnd)
    }

    override fun commit(text: String) = connection.commitText(text, 1, null)

    companion object {
        /** Null when no text field is focused (the connection is a dummy then). */
        fun of(service: AccessibilityService): ServiceKeyboard? {
            val inputMethod = service.inputMethod ?: return null
            val connection = inputMethod.currentInputConnection ?: return null
            val info = inputMethod.currentInputEditorInfo ?: return null
            if (info.inputType == 0 && info.packageName == null) return null
            return ServiceKeyboard(connection)
        }
    }
}

package de.pietschie.talkpuppy.overlay

/** The focused text field, as far as the insertion logic needs it. */
interface EditableField {
    val isEditable: Boolean
    val isPassword: Boolean

    /**
     * A field in a web page (browser, WebView). Those apply a new text
     * asynchronously, so replacing it can't be verified right away.
     */
    val isWebContent: Boolean

    /** Current text, "" while the field only shows its hint. */
    val text: String?
    val selectionStart: Int
    val selectionEnd: Int

    /** Re-reads the field; false if it's gone. */
    fun refresh(): Boolean

    /** Replaces the whole text. Never called without a value. */
    fun setText(value: String): Boolean
    fun setSelection(start: Int, end: Int): Boolean

    /** Pastes the clipboard at the cursor. */
    fun paste(): Boolean
}

/** Typing into the focused field like a keyboard (Android 13+). */
interface KeyboardInput {
    /** The characters right before and after the selection, if any. */
    fun charsAroundSelection(): Pair<Char?, Char?>
    fun commit(text: String)
}

/**
 * Puts a transcript into the text field that has the cursor, trying the
 * most precise way first:
 *
 * 1. Android 13+: the accessibility service's own input connection, exactly
 *    like a keyboard typing (native fields, browsers, WebViews, password
 *    fields; the user's keyboard stays active). As commitText doesn't say
 *    whether the field took the text, it is checked afterwards where the
 *    field can be read.
 * 2. Replacing the field's text with the dictation spliced in at the
 *    selection, then the cursor after it (not for password fields, whose
 *    text can't be read, nor web fields, which apply it asynchronously).
 * 3. Clipboard + paste.
 * 4. Clipboard only; the user pastes by hand.
 *
 * Pure logic: the Android side (fields, keyboard, clipboard, timing) comes
 * in through the constructor, see [AndroidTextInserter]. Nothing it reads
 * is stored or logged.
 */
class TextInserter(
    private val keyboard: () -> KeyboardInput?,
    private val focusedField: () -> EditableField?,
    private val copyToClipboard: (String) -> Unit,
    private val schedule: (delayMs: Long, action: () -> Unit) -> Unit,
) {
    enum class Outcome { INSERTED, COPIED }

    /** Inserts [text]; [done] gets the outcome (possibly a bit later). */
    fun insert(text: String, done: (Outcome) -> Unit) {
        val input = keyboard()
        if (input != null) {
            val field = focusedField()
            val lengthBefore = field?.text?.length ?: 0
            val (before, after) = input.charsAroundSelection()
            input.commit(withSpaces(before, after, text))
            schedule(VERIFY_DELAY_MS) { done(verifyCommit(field, lengthBefore, text)) }
            return
        }
        done(insertIntoField(text))
    }

    private fun verifyCommit(field: EditableField?, lengthBefore: Int, text: String): Outcome {
        // Where the field can't be read, trust the commit.
        if (field == null || field.isPassword || !field.refresh()) return Outcome.INSERTED
        val now = field.text ?: return Outcome.INSERTED
        if (now.contains(text.trim()) || now.length > lengthBefore) return Outcome.INSERTED
        copyToClipboard(text)
        return Outcome.COPIED
    }

    private fun insertIntoField(text: String): Outcome {
        val field = focusedField()
        if (field == null) {
            copyToClipboard(text)
            return Outcome.COPIED
        }
        // Web fields get the paste right away: SET_TEXT there shows up only
        // later, and a failed-looking check would then paste it a second time.
        if (field.isEditable && !field.isPassword && !field.isWebContent && setTextAtSelection(field, text)) {
            return Outcome.INSERTED
        }
        val (before, after) = if (field.isPassword) null to null else charsAround(field)
        copyToClipboard(withSpaces(before, after, text))
        return if (field.paste()) Outcome.INSERTED else Outcome.COPIED
    }

    private fun setTextAtSelection(field: EditableField, text: String): Boolean {
        val splice = splice(field.text.orEmpty(), field.selectionStart, field.selectionEnd, text)
        if (!field.setText(splice.newText)) return false
        // Some editors (rich web editors) accept the action but ignore it;
        // only then is the cursor moved (it'd point past the old text).
        field.refresh()
        if (field.text?.contains(splice.inserted.trim()) != true) return false
        field.setSelection(splice.caret, splice.caret)
        return true
    }

    private fun charsAround(field: EditableField): Pair<Char?, Char?> {
        val current = field.text.orEmpty()
        val start = minOf(field.selectionStart, field.selectionEnd)
        val end = maxOf(field.selectionStart, field.selectionEnd)
        if (start !in 0..current.length || end !in 0..current.length) return current.lastOrNull() to null
        return current.getOrNull(start - 1) to current.getOrNull(end)
    }

    /** Result of putting [inserted] into a text at the selection. */
    data class Splice(val newText: String, val caret: Int, val inserted: String)

    companion object {
        const val VERIFY_DELAY_MS = 300L

        /**
         * Separates the dictation from the text around it: a space in front
         * after anything but whitespace, and one behind when a word follows
         * directly (not before punctuation, which belongs to what's there).
         */
        fun withSpaces(before: Char?, after: Char?, text: String): String {
            var result = text
            if (before != null && !before.isWhitespace() && !result.startsWith(' ')) result = " $result"
            if (after != null && after.isLetterOrDigit() && !result.endsWith(' ')) result = "$result "
            return result
        }

        /**
         * Replaces the selection [selectionStart]..[selectionEnd] of [current]
         * (in either order) with [text]; an invalid selection means the end.
         */
        fun splice(current: String, selectionStart: Int, selectionEnd: Int, text: String): Splice {
            val valid = selectionStart in 0..current.length && selectionEnd in 0..current.length
            val from = if (valid) minOf(selectionStart, selectionEnd) else current.length
            val to = if (valid) maxOf(selectionStart, selectionEnd) else current.length
            val inserted = withSpaces(current.getOrNull(from - 1), current.getOrNull(to), text)
            return Splice(
                newText = current.substring(0, from) + inserted + current.substring(to),
                caret = from + inserted.length,
                inserted = inserted,
            )
        }
    }
}

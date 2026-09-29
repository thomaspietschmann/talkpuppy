package de.pietschie.talkpuppy.overlay

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

/** A text field that behaves like an EditText, with switches for failures. */
private class FakeField(
    var value: String = "",
    var start: Int = value.length,
    var end: Int = start,
    override val isPassword: Boolean = false,
    override val isEditable: Boolean = true,
    override val isWebContent: Boolean = false,
    var acceptsSetText: Boolean = true,
    /** Accepts SET_TEXT but keeps its old text (some web editors). */
    var ignoresSetText: Boolean = false,
    var acceptsPaste: Boolean = true,
    var gone: Boolean = false,
) : EditableField {
    var clipboard: String? = null
    val actions = mutableListOf<String>()

    override val text: String? get() = if (isPassword) null else value
    override val selectionStart get() = start
    override val selectionEnd get() = end

    override fun refresh() = !gone

    override fun setText(value: String): Boolean {
        actions.add("setText")
        if (!acceptsSetText) return false
        if (!ignoresSetText) this.value = value
        return true
    }

    override fun setSelection(start: Int, end: Int): Boolean {
        actions.add("setSelection $start")
        this.start = start
        this.end = end
        return true
    }

    override fun paste(): Boolean {
        actions.add("paste")
        if (!acceptsPaste) return false
        val clip = clipboard ?: return false
        val from = minOf(start, end)
        value = value.substring(0, from) + clip + value.substring(maxOf(start, end))
        start = from + clip.length
        end = start
        return true
    }
}

/** The Android 13+ keyboard path, typing into [field] (or nowhere). */
private class FakeKeyboard(private val field: FakeField?, private val swallows: Boolean = false) : KeyboardInput {
    val committed = mutableListOf<String>()

    override fun charsAroundSelection(): Pair<Char?, Char?> {
        val f = field ?: return null to null
        val from = minOf(f.start, f.end)
        val to = maxOf(f.start, f.end)
        return f.value.getOrNull(from - 1) to f.value.getOrNull(to)
    }

    override fun commit(text: String) {
        committed.add(text)
        val f = field ?: return
        if (swallows) return
        val from = minOf(f.start, f.end)
        f.value = f.value.substring(0, from) + text + f.value.substring(maxOf(f.start, f.end))
        f.start = from + text.length
        f.end = f.start
    }
}

class TextInserterTest {
    private var clipboard: String? = null
    private val scheduled = mutableListOf<Long>()

    private fun inserter(keyboard: KeyboardInput?, field: FakeField?) = TextInserter(
        keyboard = { keyboard },
        focusedField = { field },
        copyToClipboard = { text ->
            clipboard = text
            field?.clipboard = text
        },
        // Run delayed checks right away, but record that one was scheduled.
        schedule = { delay, action ->
            scheduled.add(delay)
            action()
        },
    )

    private fun insert(keyboard: KeyboardInput?, field: FakeField?, text: String): TextInserter.Outcome {
        var outcome: TextInserter.Outcome? = null
        inserter(keyboard, field).insert(text) { outcome = it }
        return outcome!!
    }

    // ── Pure helpers ────────────────────────────────────────────────────

    @Test
    fun `leading space only after a non-whitespace character`() {
        assertEquals(" Hallo", TextInserter.withSpaces('x', null, "Hallo"))
        assertEquals("Hallo", TextInserter.withSpaces(' ', null, "Hallo"))
        assertEquals("Hallo", TextInserter.withSpaces('\n', null, "Hallo"))
        assertEquals("Hallo", TextInserter.withSpaces(null, null, "Hallo"))
        assertEquals(" Hallo", TextInserter.withSpaces('x', null, " Hallo"))
    }

    @Test
    fun `trailing space only before a word`() {
        assertEquals("Hallo ", TextInserter.withSpaces(null, 'W', "Hallo"))
        assertEquals("Hallo ", TextInserter.withSpaces(null, '3', "Hallo"))
        assertEquals("Hallo", TextInserter.withSpaces(null, '.', "Hallo"))
        assertEquals("Hallo", TextInserter.withSpaces(null, ' ', "Hallo"))
        assertEquals(" Hallo ", TextInserter.withSpaces('a', 'b', "Hallo"))
    }

    @Test
    fun `splice at the end of existing text`() {
        val s = TextInserter.splice("Hallo", 5, 5, "Welt")
        assertEquals("Hallo Welt", s.newText)
        assertEquals(10, s.caret)
    }

    @Test
    fun `splice in the middle keeps the rest`() {
        val s = TextInserter.splice("Ich  heute", 4, 4, "komme")
        assertEquals("Ich komme heute", s.newText)
        assertEquals(9, s.caret)
    }

    @Test
    fun `splice right before a word separates both sides`() {
        assertEquals("Hallo schöne Welt", TextInserter.splice("HalloWelt", 5, 5, "schöne").newText)
    }

    @Test
    fun `splice replacing everything adds no spaces`() {
        val s = TextInserter.splice("Hallo Welt", 0, 10, "Neu")
        assertEquals("Neu", s.newText)
        assertEquals(3, s.caret)
    }

    @Test
    fun `splice replaces a selection, in either direction`() {
        assertEquals("Ich gehe heim", TextInserter.splice("Ich laufe heim", 4, 9, "gehe").newText)
        assertEquals("Ich gehe heim", TextInserter.splice("Ich laufe heim", 9, 4, "gehe").newText)
    }

    @Test
    fun `splice with an invalid selection appends`() {
        assertEquals("abc def", TextInserter.splice("abc", -1, -1, "def").newText)
        assertEquals("abc def", TextInserter.splice("abc", 7, 9, "def").newText)
    }

    @Test
    fun `splice into an empty field`() {
        val s = TextInserter.splice("", 0, 0, "Hallo")
        assertEquals("Hallo", s.newText)
        assertEquals(5, s.caret)
    }

    // ── Keyboard path (Android 13+) ─────────────────────────────────────

    @Test
    fun `keyboard path types at the cursor and adds a space`() {
        val field = FakeField("Hallo")
        val keyboard = FakeKeyboard(field)
        assertEquals(TextInserter.Outcome.INSERTED, insert(keyboard, field, "Welt"))
        assertEquals(listOf(" Welt"), keyboard.committed)
        assertEquals("Hallo Welt", field.value)
        assertEquals(listOf(TextInserter.VERIFY_DELAY_MS), scheduled)
        assertNull(clipboard)
        assertTrue(field.actions.isEmpty())
    }

    @Test
    fun `keyboard path replacing a selection looks outside it for spaces`() {
        val field = FakeField("Hallo Welt", start = 0, end = 10)
        val keyboard = FakeKeyboard(field)
        insert(keyboard, field, "Neu")
        assertEquals(listOf("Neu"), keyboard.committed)
        assertEquals("Neu", field.value)
    }

    @Test
    fun `keyboard path falls back to the clipboard when nothing arrived`() {
        val field = FakeField("Hallo")
        assertEquals(TextInserter.Outcome.COPIED, insert(FakeKeyboard(field, swallows = true), field, "Welt"))
        assertEquals("Welt", clipboard)
    }

    @Test
    fun `keyboard path trusts the commit where the field can't be read`() {
        assertEquals(TextInserter.Outcome.INSERTED, insert(FakeKeyboard(null), null, "Welt"))
        val password = FakeField(isPassword = true)
        assertEquals(TextInserter.Outcome.INSERTED, insert(FakeKeyboard(password), password, "geheim"))
        assertNull(clipboard)
    }

    @Test
    fun `keyboard path trusts the commit when the field is gone`() {
        val field = FakeField("Hallo", gone = true)
        assertEquals(TextInserter.Outcome.INSERTED, insert(FakeKeyboard(field), field, "Welt"))
    }

    // ── Without keyboard path (Android 12 and older, or no connection) ──

    @Test
    fun `sets the text at the selection and moves the cursor behind it`() {
        val field = FakeField("Ich  heute", start = 4)
        assertEquals(TextInserter.Outcome.INSERTED, insert(null, field, "komme"))
        assertEquals("Ich komme heute", field.value)
        assertEquals(listOf("setText", "setSelection 9"), field.actions)
        assertNull(clipboard)
    }

    @Test
    fun `falls back to paste when set text is refused`() {
        val field = FakeField("Hallo", acceptsSetText = false)
        assertEquals(TextInserter.Outcome.INSERTED, insert(null, field, "Welt"))
        assertEquals("Hallo Welt", field.value)
        assertEquals(" Welt", clipboard)
        assertEquals(listOf("setText", "paste"), field.actions)
    }

    @Test
    fun `falls back to paste when set text is silently ignored`() {
        val field = FakeField("Hallo", ignoresSetText = true)
        assertEquals(TextInserter.Outcome.INSERTED, insert(null, field, "Welt"))
        // No cursor move into the text that never arrived.
        assertEquals(listOf("setText", "paste"), field.actions)
        assertEquals("Hallo Welt", field.value)
    }

    @Test
    fun `web fields are pasted into, not replaced`() {
        val field = FakeField("Hallo", isWebContent = true)
        assertEquals(TextInserter.Outcome.INSERTED, insert(null, field, "Welt"))
        assertEquals(listOf("paste"), field.actions)
        assertEquals("Hallo Welt", field.value)
        assertEquals(" Welt", clipboard)
    }

    @Test
    fun `password fields are never read or replaced, only pasted into`() {
        val field = FakeField(isPassword = true)
        assertEquals(TextInserter.Outcome.INSERTED, insert(null, field, "geheim"))
        assertFalse(field.actions.contains("setText"))
        assertEquals(listOf("paste"), field.actions)
        assertEquals("geheim", clipboard)
    }

    @Test
    fun `read-only fields get the clipboard`() {
        val field = FakeField("fix", isEditable = false, acceptsPaste = false)
        assertEquals(TextInserter.Outcome.COPIED, insert(null, field, "Text"))
        assertEquals(" Text", clipboard)
        assertEquals("fix", field.value)
    }

    @Test
    fun `no focused field means clipboard only`() {
        assertEquals(TextInserter.Outcome.COPIED, insert(null, null, "Text"))
        assertEquals("Text", clipboard)
    }

    @Test
    fun `paste after a word before the cursor adds a space`() {
        val field = FakeField("Ende.", acceptsSetText = false)
        insert(null, field, "Neu")
        assertEquals("Ende. Neu", field.value)
    }
}

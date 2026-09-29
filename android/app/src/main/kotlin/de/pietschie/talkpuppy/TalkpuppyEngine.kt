package de.pietschie.talkpuppy

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

/**
 * The one Flutter engine of the process, shared by the app screen and the
 * floating button: one Dart app, one transcriber, one loaded model. Whoever
 * needs it first starts it (the activity, or the accessibility service when
 * the button is tapped with the app screen gone); it lives as long as the
 * process, which the bound accessibility service keeps alive.
 */
object TalkpuppyEngine {
    private const val ID = "talkpuppy"

    fun get(context: Context): FlutterEngine {
        FlutterEngineCache.getInstance().get(ID)?.let { return it }
        val engine = FlutterEngine(context.applicationContext)
        engine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        FlutterEngineCache.getInstance().put(ID, engine)
        return engine
    }
}

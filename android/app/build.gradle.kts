import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing: CI injects SIGNING_* environment variables; locally
// android/key.properties (gitignored, copy of
// ~/Keystores/talkpuppy-release.properties) is read. With neither, the
// release build falls back to the debug key so `flutter run --release`
// still works.
val keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) file.inputStream().use { load(it) }
    System.getenv("SIGNING_KEYSTORE_PATH")?.let { path ->
        setProperty("storeFile", path)
        setProperty("storePassword", System.getenv("SIGNING_STORE_PASSWORD") ?: "")
        setProperty("keyAlias", System.getenv("SIGNING_KEY_ALIAS") ?: "")
        setProperty("keyPassword", System.getenv("SIGNING_KEY_PASSWORD") ?: "")
    }
}

android {
    namespace = "de.pietschie.talkpuppy"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "de.pietschie.talkpuppy"
        // sherpa_onnx / ONNX Runtime require API 24+
        minSdk = maxOf(flutter.minSdkVersion, 24)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = (keystoreProperties["storeFile"] as String?)?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            signingConfig = if (keystoreProperties.isEmpty) {
                signingConfigs.getByName("debug")
            } else {
                signingConfigs.getByName("release")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

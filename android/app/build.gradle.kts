plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
import java.util.Properties
import java.io.FileInputStream

// Load local.properties (Flutter: android/local.properties, build.gradle.kts is in android/app/)
val localProperties = Properties()
val localPropertiesFile = file("../local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}

android {
    namespace = "com.example.moodmate"
    buildFeatures {
        buildConfig = true
    }
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.moodmate"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // Expose Adjust app token to code via BuildConfig (read from local.properties: adjustAppToken)
        val adjustToken = (localProperties["adjustAppToken"] as String?) ?: ""
        buildConfigField("String", "ADJUST_APP_TOKEN", "\"$adjustToken\"")
        // Adjust test mode: Set "adjustTestMode=true" in local.properties to inject test attribution data
        val adjustTestMode = (localProperties["adjustTestMode"] as String?) ?: "false"
        buildConfigField("String", "ADJUST_TEST_MODE", "\"$adjustTestMode\"")
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Adjust SDK and required dependencies
    implementation("com.adjust.sdk:adjust-android:4.38.5")
    implementation("com.android.installreferrer:installreferrer:2.2")
    implementation("com.google.android.gms:play-services-ads-identifier:18.0.1")
}

flutter {
    source = "../.."
}

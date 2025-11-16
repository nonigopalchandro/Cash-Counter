plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

// Load signing config from key.properties
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
keystoreProperties.load(keystorePropertiesFile.inputStream())

android {
    namespace = "com.tayan.cash_counter"
    compileSdk = 35
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.tayan.cash_counter"
        minSdk = 21
        targetSdk = 35
        versionCode = 2
        versionName = "1.1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false       // Disable code shrinking
            isShrinkResources = false     // Disable resource shrinking
        }
    }
}

flutter {
    source = "../.."
}
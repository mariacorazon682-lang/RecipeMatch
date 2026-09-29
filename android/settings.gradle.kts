pluginManagement {
    val flutterSdkPath = run {
        val localPropertiesFile = file("local.properties")
        var sdkPath: String? = null
        if (localPropertiesFile.exists()) {
            localPropertiesFile.readLines().forEach { line ->
                val parts = line.split("=", limit = 2)
                if (parts.size == 2 && parts[0].trim() == "flutter.sdk") {
                    sdkPath = parts[1].trim()
                }
            }
        }
        require(sdkPath != null) { "flutter.sdk not set in local.properties" }
        sdkPath!!
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.4.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}

include(":app")

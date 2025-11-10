plugins {
    id("com.android.application") apply false
    id("com.android.library") apply false
    id("org.jetbrains.kotlin.android") apply false
    // FIX: Added version number (e.g., "4.4.1") to resolve the 'was not found' error
    id("com.google.gms.google-services") version "4.4.1" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

//  Unified build directory for all modules
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}


subprojects {
    afterEvaluate {
        // Kotlin target fix
        plugins.withId("org.jetbrains.kotlin.android") {
            tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
                kotlinOptions.jvmTarget = "17"
            }
        }

        // Java compatibility fix
        extensions.findByName("android")?.let { ext ->
            try {
                (ext as com.android.build.gradle.BaseExtension).compileOptions {
                    sourceCompatibility = JavaVersion.VERSION_17
                    targetCompatibility = JavaVersion.VERSION_17
                }
            } catch (_: Exception) {
                // Ignore if already finalized
            }
        }

        // Use JVM Toolchain for Kotlin
        extensions.findByType<org.jetbrains.kotlin.gradle.dsl.KotlinJvmProjectExtension>()?.jvmToolchain(17)
    }
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
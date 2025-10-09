plugins {
    id("com.android.application") version "8.3.2" apply false
    id("com.android.library")     version "8.3.2" apply false
    id("org.jetbrains.kotlin.android") version "1.9.24" apply false
    // ✅ Google Services plugin
    id("com.google.gms.google-services") version "4.4.2" apply false
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

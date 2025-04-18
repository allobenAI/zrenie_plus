# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Сохраняем классы моделей
-keep class com.zrenieplus.zrenie_plus_app.models.** { *; }

# Для правильной работы рефлексии
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keepattributes Signature
-keepattributes Exceptions

# Оптимизация для JSON
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Настройки для Provider
-keep class com.google.android.material.** { *; }
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**

# Игнорирование классов Google Play Core
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Добавляем правила для игнорирования отсутствующих классов
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Flutter wrapper
-keep class io.flutter.plugin.editing.**  { *; } 
# Keep classes related to drift
-keep public class * extends org.sqlite.JDBC
-keep class * extends androidx.room.RoomDatabase
-keep class * extends androidx.room.DatabaseView
-keep @androidx.room.Entity class *
-keep @androidx.room.Dao class *
-keep @androidx.room.TypeConverter class *

# Keep all data classes (they are used by drift through reflection)
-keepclassmembers class * extends com.google.gson.TypeAdapter {
    <init>(com.google.gson.Gson);
}
-keep class * implements java.io.Serializable {
    *;
}

# This is relevant if you use the web-sqlite3 driver.
# It keeps a constructor used by the web backend to create a database.
-keepclassmembers class * {
    public <init>(java.lang.String);
}
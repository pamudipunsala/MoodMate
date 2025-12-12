package com.example.moodmate

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val URL_LAUNCHER_CHANNEL = "com.example.moodmate/url_launcher"
    private val ADJUST_CHANNEL = "com.example.moodmate/adjust"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // URL Launcher channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, URL_LAUNCHER_CHANNEL)
            .setMethodCallHandler { call, result ->
                Log.d("MainActivity", "📞 URL Launcher channel method called: ${call.method}")
                if (call.method == "launchUrl") {
                    val url = when {
                        call.arguments is Map<*, *> -> (call.arguments as Map<*, *>)["url"] as? String
                        call.arguments is String -> call.arguments as String
                        else -> null
                    }

                    if (url != null && url.isNotEmpty()) {
                        Log.d("MainActivity", "📞 launchUrl called with URL: $url")
                        try {
                            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            
                            // Check if intent can be resolved
                            val resolveInfo = intent.resolveActivity(packageManager)
                            if (resolveInfo != null) {
                                Log.d("MainActivity", "✅ Resolved activity for URL")
                                startActivity(intent)
                                result.success(true)
                                Log.d("MainActivity", "✅ Successfully opened URL: $url")
                            } else {
                                Log.e("MainActivity", "❌ No activity found to handle URL: $url")
                                // Try alternative: use application context
                                try {
                                    applicationContext.startActivity(intent)
                                    result.success(true)
                                    Log.d("MainActivity", "✅ Opened URL using applicationContext: $url")
                                } catch (e2: Exception) {
                                    Log.e("MainActivity", "❌ Failed with applicationContext too: ${e2.message}", e2)
                                    result.error("ERROR", "No activity found to handle URL: ${e2.message}", null)
                                }
                            }
                        } catch (e: Exception) {
                            Log.e("MainActivity", "❌ Exception opening URL: ${e.message}", e)
                            Log.e("MainActivity", "   Exception type: ${e.javaClass.simpleName}")
                            result.error("ERROR", "Could not open URL: ${e.message}", null)
                        }
                    } else {
                        Log.e("MainActivity", "❌ URL argument is null or empty")
                        result.error("ERROR", "URL argument is null or empty", null)
                    }
                } else {
                    result.notImplemented()
                }
            }

        // Adjust attribution channel - read directly from SharedPreferences
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ADJUST_CHANNEL)
            .setMethodCallHandler { call, result ->
                Log.d("MainActivity", "📞 Adjust channel method called: ${call.method}")
                when (call.method) {
                    "getAdjustAttribution" -> {
                        try {
                            val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                            val attribution = mapOf(
                                "source" to (prefs.getString("flutter.adjust_source", "") ?: ""),
                                "campaign" to (prefs.getString("flutter.adjust_campaign", "") ?: ""),
                                "adgroup" to (prefs.getString("flutter.adjust_adgroup", "") ?: ""),
                                "creative" to (prefs.getString("flutter.adjust_creative", "") ?: ""),
                                "trackerName" to (prefs.getString("flutter.adjust_trackerName", "") ?: ""),
                                "trackerToken" to (prefs.getString("flutter.adjust_trackerToken", "") ?: ""),
                                "adjustDeviceId" to (prefs.getString("flutter.adjust_device_id", "") ?: "")
                            )
                            Log.d("MainActivity", "📤 Returning Adjust attribution: $attribution")
                            result.success(attribution)
                        } catch (e: Exception) {
                            result.error("ERROR", "Could not get Adjust attribution: ${e.message}", null)
                            Log.e("MainActivity", "❌ Error getting Adjust attribution: ${e.message}", e)
                        }
                    }
                    "getAndroidId" -> {
                        try {
                            val androidId = Settings.Secure.getString(
                                contentResolver,
                                Settings.Secure.ANDROID_ID
                            ) ?: ""
                            Log.d("MainActivity", "📤 Returning Android ID: $androidId")
                            result.success(androidId)
                        } catch (e: Exception) {
                            result.error("ERROR", "Could not get Android ID: ${e.message}", null)
                            Log.e("MainActivity", "❌ Error getting Android ID: ${e.message}", e)
                        }
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }
    }
}

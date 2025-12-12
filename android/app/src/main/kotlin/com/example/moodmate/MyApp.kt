package com.example.moodmate

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import com.adjust.sdk.Adjust
import com.adjust.sdk.AdjustAttribution
import com.adjust.sdk.AdjustConfig
import com.adjust.sdk.LogLevel
import io.flutter.plugin.common.MethodChannel

class MyApp : Application() {
    private var methodChannel: MethodChannel? = null
    
    fun setMethodChannel(channel: MethodChannel) {
        methodChannel = channel
    }
    
    override fun onCreate() {
        super.onCreate()

        val appToken = BuildConfig.ADJUST_APP_TOKEN
        if (appToken.isEmpty()) {
            Log.e("AdjustAttribution", "❌ ADJUST_APP_TOKEN is empty! Check local.properties")
            return
        }
        
        // Use SANDBOX for debug builds (faster attribution for testing)
        // Use PRODUCTION for release builds (requires tracking link for attribution)
        val environment = if (BuildConfig.DEBUG) {
            AdjustConfig.ENVIRONMENT_SANDBOX
        } else {
            AdjustConfig.ENVIRONMENT_PRODUCTION
        }
        
        val config = AdjustConfig(this, appToken, environment)
        
        Log.d("AdjustAttribution", "🔧 Adjust SDK initialized")
        Log.d("AdjustAttribution", "   Environment: ${if (BuildConfig.DEBUG) "SANDBOX (for testing)" else "PRODUCTION"}")
        Log.d("AdjustAttribution", "   App Token: ${appToken.take(8)}...")

        if (BuildConfig.DEBUG) {
            config.setLogLevel(LogLevel.VERBOSE)
            Log.d("AdjustAttribution", "   Log Level: VERBOSE")
        }

        config.setOnAttributionChangedListener { attribution: AdjustAttribution? ->
            attribution?.let {
                Log.d("AdjustAttribution", "✅ Attribution callback fired!")
                Log.d("AdjustAttribution", "   Network: ${it.network}")
                Log.d("AdjustAttribution", "   Campaign: ${it.campaign}")
                Log.d("AdjustAttribution", "   Adgroup: ${it.adgroup}")
                Log.d("AdjustAttribution", "   Creative: ${it.creative}")
                Log.d("AdjustAttribution", "   Tracker: ${it.trackerName} (${it.trackerToken})")
                Log.d("AdjustAttribution", "   ADID: ${it.adid}")
                saveAdjustAttribution(it)
            } ?: run {
                Log.d("AdjustAttribution", "⚠️ Attribution callback fired but attribution is null")
            }
        }

        Adjust.onCreate(config)
        
        // TEST MODE: If enabled, inject test attribution data for development/testing
        // This allows testing attribution flow without needing a real Adjust tracking link
        // To enable: Add "adjustTestMode=true" to android/local.properties
        if (BuildConfig.DEBUG && BuildConfig.ADJUST_TEST_MODE == "true") {
            Log.d("AdjustAttribution", "🧪 TEST MODE ENABLED - Injecting test attribution data")
            android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
                saveTestAttribution()
            }, 1000) // Wait 1 second for SDK to initialize
        }
        
        android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
            try {
                val attribution = Adjust.getAttribution()
                attribution?.let {
                    Log.d("AdjustAttribution", "✅ Got attribution directly: $it")
                    saveAdjustAttribution(it)
                }
            } catch (e: Exception) {
                Log.d("AdjustAttribution", "⚠️ Could not get attribution directly: ${e.message}")
            }
        }, 2000)
        
        android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
            try {
                val attribution = Adjust.getAttribution()
                attribution?.let {
                    saveAdjustAttribution(it)
                }
            } catch (e: Exception) {
                Log.d("AdjustAttribution", "⚠️ Could not retry attribution: ${e.message}")
            }
        }, 5000)
        
        registerActivityLifecycleCallbacks(object : Application.ActivityLifecycleCallbacks {
            override fun onActivityResumed(activity: Activity) {
                Adjust.onResume()
            }
            override fun onActivityPaused(activity: Activity) {
                Adjust.onPause()
            }
            override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {}
            override fun onActivityStarted(activity: Activity) {}
            override fun onActivityStopped(activity: Activity) {}
            override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {}
            override fun onActivityDestroyed(activity: Activity) {}
        })
    }
    
    private fun saveAdjustAttribution(attribution: AdjustAttribution) {
        val source = (attribution.network ?: "").replace(" ", "")
        val campaign = attribution.campaign ?: ""
        val adgroup = attribution.adgroup ?: ""
        val creative = attribution.creative ?: ""
        val trackerName = attribution.trackerName ?: ""
        val trackerToken = attribution.trackerToken ?: ""
        val adjustDeviceId = attribution.adid ?: ""

        Log.d("AdjustAttribution", "source=$source, campaign=$campaign, adgroup=$adgroup, creative=$creative, trackerName=$trackerName, trackerToken=$trackerToken, adjustDeviceId=$adjustDeviceId")

        saveAttributionToPrefs(source, campaign, adgroup, creative, trackerName, trackerToken, adjustDeviceId)
    }
    
    // Helper method to save attribution data directly (used by test mode)
    private fun saveAttributionToPrefs(
        source: String,
        campaign: String,
        adgroup: String,
        creative: String,
        trackerName: String,
        trackerToken: String,
        adjustDeviceId: String
    ) {
        val prefs: SharedPreferences = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val editor = prefs.edit()
        editor.putString("flutter.adjust_source", source)
        editor.putString("flutter.adjust_campaign", campaign)
        editor.putString("flutter.adjust_adgroup", adgroup)
        editor.putString("flutter.adjust_creative", creative)
        editor.putString("flutter.adjust_trackerName", trackerName)
        editor.putString("flutter.adjust_trackerToken", trackerToken)
        editor.putString("flutter.adjust_device_id", adjustDeviceId)
        val saved = editor.commit()
        
        Log.d("AdjustAttribution", "💾 Saved attribution to SharedPreferences: source=$source, campaign=$campaign, adgroup=$adgroup, creative=$creative, trackerName=$trackerName, trackerToken=$trackerToken, adjustDeviceId=$adjustDeviceId")
        
        if (methodChannel != null) {
            try {
                methodChannel!!.invokeMethod("adjustAttribution", mapOf(
                    "source" to source,
                    "campaign" to campaign,
                    "adgroup" to adgroup,
                    "creative" to creative,
                    "trackerName" to trackerName,
                    "trackerToken" to trackerToken,
                    "adjustDeviceId" to adjustDeviceId
                ))
                Log.d("AdjustAttribution", "✅ Method channel called successfully")
            } catch (e: Exception) {
                Log.e("AdjustAttribution", "❌ Error calling method channel: ${e.message}")
            }
        }
    }
    
    // Test mode: Inject test attribution data for development/testing
    // This simulates attribution data so you can test the flow without a real Adjust tracking link
    private fun saveTestAttribution() {
        Log.d("AdjustAttribution", "🧪 Injecting test attribution data...")
        saveAttributionToPrefs(
            source = "test_network",
            campaign = "test_campaign_123",
            adgroup = "test_adgroup_456",
            creative = "test_creative_789",
            trackerName = "test_tracker",
            trackerToken = "test_token_abc",
            adjustDeviceId = "test_adid_xyz"
        )
        Log.d("AdjustAttribution", "✅ Test attribution data injected successfully")
        Log.d("AdjustAttribution", "💡 To disable test mode, remove 'adjustTestMode=true' from android/local.properties")
    }
}

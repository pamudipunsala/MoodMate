import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Set this to your backend base URL, e.g. "https://api.example.com"
/// Set to empty string to disable sending
const String kAdjustTestBaseUrl = '';

/// Reads Adjust attribution + Android ID via method channels and:
/// - builds a URL with query params: source, campaign, adgroup, creative,
///   trackerName, trackerToken, adjustDeviceId, deviceId, eventType=2
/// - opens it in the browser via native code
///
/// Usage:
///   sendAdjustDebug(); // Uses kAdjustTestBaseUrl
///   sendAdjustDebug(baseUrlOverride: 'https://your-url.com');
Future<void> sendAdjustDebug({String? baseUrlOverride}) async {
  debugPrint('═══════════════════════════════════════════════════════');
  debugPrint('🚀 sendAdjustDebug() called');
  debugPrint('═══════════════════════════════════════════════════════');

  final baseUrl = baseUrlOverride ?? kAdjustTestBaseUrl;
  if (baseUrl.isEmpty || baseUrl == '') {
    debugPrint('⚠️ kAdjustTestBaseUrl is not set; skipping Adjust debug send.');
    return;
  }

  debugPrint('📝 Base URL: $baseUrl');
  debugPrint('📝 Package name: com.example.moodmate');

  const adjustChannel = MethodChannel('com.example.moodmate/adjust');
  const urlLauncherChannel = MethodChannel('com.example.moodmate/url_launcher');

  debugPrint('📝 Adjust channel: com.example.moodmate/adjust');
  debugPrint('📝 URL launcher channel: com.example.moodmate/url_launcher');

  bool hasValues = false;
  int attempts = 0;
  const maxAttempts = 30; // 30 attempts * 500ms = 15 seconds

  String source = '';
  String campaign = '';
  String adgroup = '';
  String creative = '';
  String trackerName = '';
  String trackerToken = '';
  String adjustDeviceId = '';

  debugPrint('⏳ Waiting for Adjust attribution data...');

  // Poll native Adjust attribution
  while (!hasValues && attempts < maxAttempts) {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final result = await adjustChannel.invokeMethod('getAdjustAttribution');
      if (result is Map) {
        source = result['source'] as String? ?? '';
        campaign = result['campaign'] as String? ?? '';
        adgroup = result['adgroup'] as String? ?? '';
        creative = result['creative'] as String? ?? '';
        trackerName = result['trackerName'] as String? ?? '';
        trackerToken = result['trackerToken'] as String? ?? '';
        adjustDeviceId = result['adjustDeviceId'] as String? ?? '';

        hasValues =
            source.isNotEmpty ||
            campaign.isNotEmpty ||
            adgroup.isNotEmpty ||
            creative.isNotEmpty ||
            trackerName.isNotEmpty ||
            trackerToken.isNotEmpty ||
            adjustDeviceId.isNotEmpty;
      }
    } catch (e) {
      // Ignore and retry
    }

    if (hasValues) {
      debugPrint(
        '✅ Adjust attribution data received after ${attempts * 500}ms',
      );
    } else if (attempts % 4 == 0) {
      // Log every 2 seconds
      debugPrint('⏳ Still waiting... (${attempts * 500}ms elapsed)');
    }

    attempts++;
  }

  if (!hasValues) {
    debugPrint(
      '⚠️ Timeout: No attribution data received after ${maxAttempts * 500}ms',
    );
    // Try one more time
    try {
      final result = await adjustChannel.invokeMethod('getAdjustAttribution');
      if (result is Map) {
        source = result['source'] as String? ?? '';
        campaign = result['campaign'] as String? ?? '';
        adgroup = result['adgroup'] as String? ?? '';
        creative = result['creative'] as String? ?? '';
        trackerName = result['trackerName'] as String? ?? '';
        trackerToken = result['trackerToken'] as String? ?? '';
        adjustDeviceId = result['adjustDeviceId'] as String? ?? '';

        hasValues =
            source.isNotEmpty ||
            campaign.isNotEmpty ||
            adgroup.isNotEmpty ||
            creative.isNotEmpty ||
            trackerName.isNotEmpty ||
            trackerToken.isNotEmpty ||
            adjustDeviceId.isNotEmpty;
      }
    } catch (e) {
      debugPrint('⚠️ Final attempt failed: $e');
    }
  }

  // Get Android device ID
  String deviceId = '';
  try {
    final androidIdResult = await adjustChannel.invokeMethod('getAndroidId');
    deviceId = androidIdResult as String? ?? '';
    debugPrint('📱 Android Device ID: $deviceId');
  } catch (e) {
    debugPrint('⚠️ Could not get Android ID: $e');
  }

  // Print all values to console
  debugPrint('═══════════════════════════════════════════════════════');
  debugPrint('📤 Adjust Debug - Attribution Data:');
  debugPrint('   source: "$source"');
  debugPrint('   campaign: "$campaign"');
  debugPrint('   adgroup: "$adgroup"');
  debugPrint('   creative: "$creative"');
  debugPrint('   trackerName: "$trackerName"');
  debugPrint('   trackerToken: "$trackerToken"');
  debugPrint('   adjustDeviceId: "$adjustDeviceId"');
  debugPrint('   deviceId: "$deviceId"');
  debugPrint('   eventType: "2"');
  debugPrint('═══════════════════════════════════════════════════════');

  // Build URL with query parameters
  final queryParams = <String, String>{
    'source': source,
    'campaign': campaign,
    'adgroup': adgroup,
    'creative': creative,
    'trackerName': trackerName,
    'trackerToken': trackerToken,
    'adjustDeviceId': adjustDeviceId,
    'deviceId': deviceId,
    'eventType': '2', // Static value
  };

  final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

  debugPrint('🌐 Opening URL in browser: $uri');
  debugPrint('   Full URL with params: ${uri.toString()}');

  // Open URL in browser using platform channel
  debugPrint('📞 Calling method channel to open URL...');
  debugPrint('   Channel name: com.example.moodmate/url_launcher');
  debugPrint('   URL to open: ${uri.toString()}');

  try {
    final result = await urlLauncherChannel.invokeMethod('launchUrl', {
      'url': uri.toString(),
    });
    debugPrint('✅ Method channel returned: $result');
    if (result == true) {
      debugPrint('✅ URL should have opened in browser');
    } else {
      debugPrint('⚠️ Method channel returned false - URL may not have opened');
    }
  } on PlatformException catch (e) {
    debugPrint('❌ PlatformException opening URL:');
    debugPrint('   Code: ${e.code}');
    debugPrint('   Message: ${e.message}');
    debugPrint('   Details: ${e.details}');
    debugPrint('   URL: ${uri.toString()}');
    debugPrint(
      '   This usually means the method channel is not registered or there is an error in native code',
    );
    debugPrint(
      '   Check logcat for "MainActivity" logs: adb logcat | grep MainActivity',
    );
  } catch (e, stackTrace) {
    debugPrint('❌ Unexpected error opening URL: $e');
    debugPrint('   Stack trace: $stackTrace');
    debugPrint('   URL: ${uri.toString()}');
    debugPrint('   You can manually open this URL in a browser');
  }
}

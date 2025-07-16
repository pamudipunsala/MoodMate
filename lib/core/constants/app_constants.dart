import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'MoodMate';
  static const String appVersion = '1.0.0';
  
  // Colors - Soft Pastel Palette
  static const Color primaryColor = Color(0xFFE8F4FD); // Light Blue
  static const Color secondaryColor = Color(0xFFF3E5F5); // Light Lavender
  static const Color accentColor = Color(0xFFFFE5E5); // Light Blush
  static const Color backgroundColor = Color(0xFFFAFAFA); // Very Light Gray
  static const Color surfaceColor = Color(0xFFFFFFFF); // White
  static const Color textPrimaryColor = Color(0xFF2C3E50); // Dark Blue Gray
  static const Color textSecondaryColor = Color(0xFF7F8C8D); // Gray
  static const Color successColor = Color(0xFFA8E6CF); // Light Green
  static const Color warningColor = Color(0xFFFFD3B6); // Light Orange
  static const Color errorColor = Color(0xFFFFB3BA); // Light Red
  
  // Mood Colors
  static const Color sadColor = Color(0xFFB8E6B8); // Light Blue
  static const Color neutralColor = Color(0xFFFFE5B4); // Light Yellow
  static const Color happyColor = Color(0xFFFFB3BA); // Light Pink
  
  // Typography
  static const String fontFamily = 'Nunito';
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeXXLarge = 32.0;
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border Radius
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 24.0;
  
  // Shadows
  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8.0,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 12.0,
      offset: Offset(0, 4),
    ),
  ];
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // API Configuration
  static const String openAIBaseUrl = 'https://api.openai.com/v1';
  static const String openAIModel = 'gpt-3.5-turbo';
  
  // Storage Keys
  static const String moodEntriesKey = 'mood_entries';
  static const String chatHistoryKey = 'chat_history';
  static const String userPreferencesKey = 'user_preferences';
  
  // Emergency Resources
  static const String emergencyHotline = '988'; // US National Suicide Prevention Lifeline
  static const String emergencyText = 'Text HOME to 741741'; // Crisis Text Line
} 
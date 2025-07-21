import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'MoodMate';
  static const String appVersion = '1.0.0';
  
  // Colors - Modern Mental Health App Palette
  static const Color primaryColor = Color(0xFFE3F2FD); // Light pastel blue
  static const Color secondaryColor = Color(0xFF9C27B0); // Purple
  static const Color accentColor = Color(0xFFFF6B9D); // Pink
  static const Color backgroundColor = Color(0xF2F7F8FC); // lighter with alpha
  static const Color surfaceColor = Color(0xE6FFFFFF);    // lighter white with alpha
  static const Color textPrimaryColor = Color(0xFF1A1A2E); // Dark Blue
  static const Color textSecondaryColor = Color(0xFF6C757D); // Medium Gray
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color warningColor = Color(0xFFFF9800); // Orange
  static const Color errorColor = Color(0xFFF44336); // Red
  
  // Mood Colors - More Vibrant
  static const Color sadColor = Color(0xFF2196F3); // Blue
  static const Color neutralColor = Color(0xFFFFC107); // Amber
  static const Color happyColor = Color(0xFF4CAF50); // Green
  
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
  static const String openAIApiKey = 'sk-REPLACE_WITH_YOUR_KEY'; // <-- Set your OpenAI API key here
  
  // Storage Keys
  static const String moodEntriesKey = 'mood_entries';
  static const String chatHistoryKey = 'chat_history';
  static const String userPreferencesKey = 'user_preferences';
  
  // Emergency Resources
  static const String emergencyHotline = '1926'; // US National Suicide Prevention Lifeline
  static const String emergencyText = 'Text HOME to 741741'; // Crisis Text Line
} 
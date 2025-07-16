import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConstants.fontFamily,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppConstants.primaryColor,
        secondary: AppConstants.secondaryColor,
        surface: AppConstants.surfaceColor,
        background: AppConstants.backgroundColor,
        error: AppConstants.errorColor,
        onPrimary: AppConstants.textPrimaryColor,
        onSecondary: AppConstants.textPrimaryColor,
        onSurface: AppConstants.textPrimaryColor,
        onError: AppConstants.textPrimaryColor,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.surfaceColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppConstants.surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        ),
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: AppConstants.textPrimaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          textStyle: GoogleFonts.nunito(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.textPrimaryColor,
          textStyle: GoogleFonts.nunito(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  borderSide: BorderSide(
          color: AppConstants.textSecondaryColor.withValues(alpha: 0.2),
        ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          borderSide: BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingM,
        ),
        hintStyle: GoogleFonts.nunito(
          color: AppConstants.textSecondaryColor,
          fontSize: AppConstants.fontSizeMedium,
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.nunitoTextTheme().copyWith(
        displayLarge: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeXXLarge,
          fontWeight: FontWeight.w700,
          color: AppConstants.textPrimaryColor,
        ),
        displayMedium: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeXLarge,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
        displaySmall: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
        headlineSmall: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w500,
          color: AppConstants.textPrimaryColor,
        ),
        titleSmall: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeSmall,
          fontWeight: FontWeight.w500,
          color: AppConstants.textSecondaryColor,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w400,
          color: AppConstants.textPrimaryColor,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w400,
          color: AppConstants.textPrimaryColor,
        ),
        bodySmall: GoogleFonts.nunito(
          fontSize: AppConstants.fontSizeSmall,
          fontWeight: FontWeight.w400,
          color: AppConstants.textSecondaryColor,
        ),
      ),
      
      // Scaffold Background
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppConstants.surfaceColor,
        selectedItemColor: AppConstants.textPrimaryColor,
        unselectedItemColor: AppConstants.textSecondaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 4,
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: width * 0.18, // Responsive icon size
                  color: AppConstants.textPrimaryColor,
                ),
                SizedBox(height: height * 0.04),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppConstants.textPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.08, // Responsive font size
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Emotional Support, Anytime",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConstants.textSecondaryColor,
                    fontSize: width * 0.045, // Responsive font size
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
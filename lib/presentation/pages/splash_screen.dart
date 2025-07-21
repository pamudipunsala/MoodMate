import 'package:flutter/material.dart';
import 'package:moodmate/presentation/pages/home_screen.dart';
import '../../core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Increase the duration here (e.g., 3 seconds)
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to your main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

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
                Image.asset(
                  'assets/images/app_icon.png',
                  width: width * 0.18,
                  height: width * 0.18,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: height * 0.04),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppConstants.textPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.08,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Emotional Support, Anytime",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConstants.textSecondaryColor,
                    fontSize: width * 0.045,
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
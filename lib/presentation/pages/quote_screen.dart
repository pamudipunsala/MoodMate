import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
// import 'package:lottie/lottie.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<String> _quotes = [
    "You are stronger than you think.",
    "Every day is a fresh start.",
    "Your feelings are valid.",
    "Small steps every day.",
    "You matter. Your story matters.",
    "Breathe. You’ve got this.",
    "Progress, not perfection.",
    "Be kind to yourself.",
    "It’s okay to ask for help.",
    "You are not alone."
  ];
  late String _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = (_quotes..shuffle()).first;
  }

  void _nextQuote() {
    setState(() {
      _currentQuote = (_quotes..shuffle()).first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motivational Quote'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFAFAFF), Color(0xFFE8F4FD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.format_quote, size: 72, color: AppConstants.warningColor.withOpacity(0.7)),
                const SizedBox(height: 2), // Reduced top space
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusXL),
                  ),
                  color: Colors.white.withOpacity(0.97),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
                    child: Column(
                      children: [
                        Text(
                          _currentQuote,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppConstants.textPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "— MoodMate",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppConstants.textSecondaryColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60), // Increased bottom space
                // Daily affirmation
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppConstants.successColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                  ),
                  child: Text(
                    "Affirmation: You are enough, just as you are.",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppConstants.successColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.warningColor,
                    foregroundColor: AppConstants.textPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    ),
                  ),
                  onPressed: _nextQuote,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
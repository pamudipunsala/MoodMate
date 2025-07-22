import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
// import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

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
    "You are not alone.",
    "Difficult roads often lead to beautiful destinations.",
    "You have survived 100% of your worst days.",
    "Believe in yourself and all that you are.",
    "Storms make trees take deeper roots.",
    "You are capable of amazing things.",
    "Healing is not linear.",
    "You don’t have to control your thoughts. You just have to stop letting them control you.",
    "You are enough just as you are.",
    "Take time to do what makes your soul happy.",
    "Your present circumstances don’t determine where you can go; they merely determine where you start.",
    "You are allowed to be both a masterpiece and a work in progress.",
    "One day at a time.",
    "You are worthy of love and kindness.",
    "Let your hopes, not your hurts, shape your future.",
    "You are braver than you believe, stronger than you seem, and smarter than you think.",
    "Sometimes the people around you won’t understand your journey. They don’t need to, it’s not for them.",
    "You can do hard things.",
    "Your only limit is your mind.",
    "Start where you are. Use what you have. Do what you can.",
    "The sun will rise and we will try again.",
    "You don’t have to be perfect to be amazing.",
    "Growth is growth, no matter how small.",
    "You are worthy of the time it takes to do the things that heal your heart.",
    "Your vibe attracts your tribe.",
    "You are the author of your own story.",
    "Don’t let yesterday take up too much of today.",
    "You are more than your mistakes.",
    "It’s okay to rest. Rest is productive.",
    "You are not your thoughts.",
    "You are doing better than you think.",
    "You are a light in this world.",
    "You are not behind in life. There’s no set schedule.",
    "You are allowed to take up space.",
    "You are not a burden.",
    "You are loved, even on days you don’t feel it.",
    "You are making a difference just by being you.",
    "You are allowed to say no to things that drain you.",
    "You are not your struggles.",
    "You are enough, always.",
    "You are worthy of all the good things in life.",
    "You are resilient, strong, and brave.",
    "You are allowed to feel and heal at your own pace.",
    "You are a work in progress, and that’s okay.",
    "You are not alone on this journey.",
    "You are capable of rewriting your story.",
    "You are deserving of happiness and peace.",
    "You are a beautiful person, inside and out.",
    "You are not defined by your past.",
    "You are free to create the life you desire.",
    "You are worthy of respect and kindness.",
    "You are enough, just as you are right now.",
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
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
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.format_quote, size: width * 0.18, color: AppConstants.warningColor.withOpacity(0.7)),
                    SizedBox(height: height * 0.01),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.04),
                      ),
                      color: Colors.white.withOpacity(0.97),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.07),
                        child: Column(
                          children: [
                            Text(
                              _currentQuote,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppConstants.textPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                height: 1.3,
                                fontSize: width * 0.045,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              "— MoodMate",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppConstants.textSecondaryColor,
                                fontStyle: FontStyle.italic,
                                fontSize: width * 0.035,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    // Daily affirmation
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.018),
                      decoration: BoxDecoration(
                        color: AppConstants.successColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Text(
                        "Affirmation: You are enough, just as you are.",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppConstants.successColor,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.035,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 228, 153, 41),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.018),
                      ),
                      onPressed: _nextQuote,
                      icon: const Icon(Icons.refresh),
                      label: Text('Next', style: TextStyle(fontSize: width * 0.04)),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 202, 102, 135),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.018),
                      ),
                      onPressed: () {
                        Share.share('"$_currentQuote" — MoodMate');
                      },
                      icon: const Icon(Icons.share),
                      label: Text('Share', style: TextStyle(fontSize: width * 0.04)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 
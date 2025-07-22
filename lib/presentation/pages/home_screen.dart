import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood/mood_bloc.dart';
import '../bloc/quotes/quotes_bloc.dart';
import 'mood_checkin_screen.dart';
import 'chat_screen.dart';
import 'emergency_screen.dart';
import 'quote_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoodBloc>().add(LoadMoodEntries());
    context.read<QuotesBloc>().add(LoadQuoteOfTheDay());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(width),
              SizedBox(height: height * 0.015),
              _buildTodayMood(),
              SizedBox(height: height * 0.015),
              _buildQuoteOfTheDay(),
              SizedBox(height: height * 0.015),
              _buildQuickActions(width, height),
              SizedBox(height: height * 0.02), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome to',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppConstants.textSecondaryColor,
                fontSize: width * 0.06,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                height: 1.0, // Responsive, minimal line height
              ),
            ),
            SizedBox(height: width * 0.01),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppConstants.textPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.10,
                letterSpacing: 1.2,
                height: 1.0, // Responsive, minimal line height
              ),
            ),
            SizedBox(height: width * 0.08),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: width * 0.0005), // Nudge icon down
          child: Image.asset(
            'assets/images/app_icon.png',
            width: width * 0.2,
            height: width * 0.2,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildTodayMood() {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        if (state is MoodLoaded && state.todayMood != null) {
          return _buildMoodCard(state.todayMood!);
        } else {
          return _buildNoMoodCard();
        }
      },
    );
  }

  Widget _buildMoodCard(MoodEntry mood) {
    String emoji;
    String label;
    Color color;

    switch (mood.mood) {
      case MoodType.sad:
        emoji = '😢';
        label = 'Sad';
        color = AppConstants.sadColor;
        break;
      case MoodType.neutral:
        emoji = '😐';
        label = 'Okay';
        color = AppConstants.neutralColor;
        break;
      case MoodType.happy:
        emoji = '😊';
        label = 'Happy';
        color = AppConstants.happyColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        color: Color(0xFFE6F4EA), // very light pastel green
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: AppConstants.softShadow,
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Mood',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppConstants.textSecondaryColor,
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppConstants.textPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (mood.note != null && mood.note!.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingS),
                  Text(
                    mood.note!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppConstants.textPrimaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoMoodCard() {
    return GestureDetector(
      onTap: () => _navigateToMoodCheckin(),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border: Border.all(
            color: AppConstants.primaryColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: AppConstants.softShadow,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              ),
              child: Icon(
                Icons.add,
                color: AppConstants.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: AppConstants.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How are you feeling?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppConstants.textPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Tap to check in with your mood',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteOfTheDay() {
    return BlocBuilder<QuotesBloc, QuotesState>(
      builder: (context, state) {
        if (state is QuotesLoaded) {
          return Container(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            decoration: BoxDecoration(
              color: Color(0xFFF3E6F9), // very light pastel purple
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
              boxShadow: AppConstants.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: AppConstants.textSecondaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.spacingS),
                    Text(
                      'Quote of the Day',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color.fromARGB(255, 162, 170, 177),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingM),
                Text(
                  state.quote,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppConstants.textPrimaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildQuickActions(double width, double height) {
    final isMobile = width < 600;
    final crossAxisCount = isMobile ? 2 : 4;
    final cardAspectRatio = isMobile ? 1.1 : 1.3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.03), // Increased space above Quick Actions
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppConstants.textPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.055,
          ),
        ),
        SizedBox(height: height * 0.015),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: width * 0.03,
          mainAxisSpacing: height * 0.015,
          childAspectRatio: cardAspectRatio,
          children: [
            _buildActionCard(
              icon: Icons.chat_bubble_outline,
              title: 'Chat',
              subtitle: 'Talk to AI',
              color: const Color.fromARGB(255, 108, 153, 185),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SimpleChatScreen()),
              ),
              width: width,
            ),
            _buildActionCard(
              icon: Icons.favorite_outline,
              title: 'Calm',
              subtitle: 'Relax & Breathe',
              color: AppConstants.accentColor,
              onTap: () => _navigateToEmergency(),
              width: width,
            ),
            _buildActionCard(
              icon: Icons.emoji_emotions_outlined,
              title: 'Check-in',
              subtitle: 'Log your mood',
              color: AppConstants.secondaryColor,
              onTap: () => _navigateToMoodCheckin(),
              width: width,
            ),
            _buildActionCard(
              icon: Icons.format_quote,
              title: 'Quote',
              subtitle: 'Get inspired',
              color: AppConstants.warningColor,
              onTap: () => _showRandomQuote(),
              width: width,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required double width,
  }) {
    final isMobile = width < 600;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isMobile ? width * 0.02 : width * 0.03),
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          boxShadow: AppConstants.softShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? width * 0.015 : width * 0.025),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              ),
              child: Icon(
                icon,
                color: color,
                size: isMobile ? width * 0.06 : width * 0.07,
              ),
            ),
            SizedBox(height: isMobile ? width * 0.01 : width * 0.02),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppConstants.textPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? width * 0.035 : width * 0.045,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppConstants.textSecondaryColor,
                fontSize: isMobile ? width * 0.025 : width * 0.035,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMoodCheckin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MoodCheckinScreen()),
    );
  }

  void _navigateToChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SimpleChatScreen()),
    );
  }

  void _navigateToEmergency() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmergencyScreen()),
    );
  }

  void _showRandomQuote() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuoteScreen()),
    );
  }
} 
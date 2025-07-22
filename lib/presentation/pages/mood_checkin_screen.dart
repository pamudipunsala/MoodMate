import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood/mood_bloc.dart';
import '../widgets/mood_selector.dart';
import 'package:share_plus/share_plus.dart';

class MoodCheckinScreen extends StatefulWidget {
  const MoodCheckinScreen({super.key});

  @override
  State<MoodCheckinScreen> createState() => _MoodCheckinScreenState();
}

class _MoodCheckinScreenState extends State<MoodCheckinScreen> {
  MoodType? selectedMood;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure BLoC is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MoodBloc>().add(LoadMoodEntries());
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mood Check-in',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: width * 0.06,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Always show mood selector
                  _buildMoodSelector(width, height),
                  SizedBox(height: height * 0.02),
                  
                  // Always show note input
                  _buildNoteInput(width, height),
                  SizedBox(height: height * 0.02),
                  
                  // Always show save button
                  _buildSaveButton(width, height),
                  SizedBox(height: height * 0.02),
                  
                  // Show mood history based on state
                  _buildMoodHistory(state, width, height),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMoodSelector(double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor.withOpacity(0.98),
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 2),
        ),
        ],
      ),
      child: MoodSelector(
        selectedMood: selectedMood,
        onMoodSelected: (mood) {
          setState(() {
            selectedMood = mood;
          });
        },
      ),
    );
  }

  Widget _buildNoteInput(double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor.withOpacity(0.98),
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 2),
        ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s on your mind? (Optional)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppConstants.textPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.04,
            ),
          ),
          SizedBox(height: height * 0.01),
          TextField(
            controller: _noteController,
            maxLines: 3,
            style: TextStyle(fontSize: width * 0.035),
            decoration: InputDecoration(
              hintText: 'Share your thoughts, feelings, or what happened today...',
              hintStyle: TextStyle(
                fontSize: width * 0.035,
                color: AppConstants.textSecondaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width * 0.02),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width * 0.02),
                borderSide: BorderSide(
                  color: AppConstants.primaryColor,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.012,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(double width, double height) {
    final isEnabled = selectedMood != null;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor.withOpacity(0.98),
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 2),
        ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? _saveMood : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppConstants.primaryColor
              : AppConstants.primaryColor.withOpacity(0.3),
          padding: EdgeInsets.symmetric(vertical: height * 0.015),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
          elevation: 0,
        ),
        child: Text(
          'Save Mood',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppConstants.textPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.04,
          ),
        ),
      ),
    );
  }

  Widget _buildMoodHistory(MoodState state, double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor.withOpacity(0.98),
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 2),
        ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Moods',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppConstants.textPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.05,
            ),
          ),
          SizedBox(height: height * 0.015),
          // Handle different states
          if (state is MoodLoading)
            Center(
              child: Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: CircularProgressIndicator(
                  strokeWidth: width * 0.01,
                ),
              ),
            )
          else if (state is MoodError)
            Center(
              child: Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: width * 0.12,
                      color: AppConstants.errorColor,
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppConstants.textPrimaryColor,
                        fontSize: width * 0.04,
                      ),
                    ),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppConstants.textSecondaryColor,
                        fontSize: width * 0.035,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else if (state is MoodLoaded)
            _buildMoodList(state.moodEntries, width, height)
          else
            _buildEmptyState(width, height),
        ],
      ),
    );
  }

  Widget _buildMoodList(List<MoodEntry> moodEntries, double width, double height) {
    final recentMoods = moodEntries.take(10).toList().reversed.toList();
    
    if (recentMoods.isEmpty) {
      return _buildEmptyState(width, height);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentMoods.length,
      itemBuilder: (context, index) {
        final mood = recentMoods[index];
        return _buildMoodHistoryItem(mood, width, height);
      },
    );
  }

  Widget _buildEmptyState(double width, double height) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_emotions_outlined,
              size: width * 0.16,
              color: AppConstants.textSecondaryColor,
            ),
            SizedBox(height: height * 0.015),
            Text(
              'No mood entries yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppConstants.textSecondaryColor,
                fontSize: width * 0.04,
              ),
            ),
            Text(
              'Start by logging your first mood!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.textSecondaryColor,
                fontSize: width * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodHistoryItem(MoodEntry mood, double width, double height) {
    String emoji;
    String label;
    Color color;
    Color bgColor;

    switch (mood.mood) {
      case MoodType.sad:
        emoji = '😢';
        label = 'Sad';
        color = AppConstants.sadColor;
        bgColor = const Color(0xFFFFE0E6); // pastel pink
        break;
      case MoodType.neutral:
        emoji = '😐';
        label = 'Okay';
        color = AppConstants.neutralColor;
        bgColor = const Color(0xFFE3F2FD); // pastel blue
        break;
      case MoodType.happy:
        emoji = '😊';
        label = 'Happy';
        color = AppConstants.happyColor;
        bgColor = const Color(0xFFFFF9C4); // pastel yellow
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(width * 0.02),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(width * 0.01),
            ),
            child: Text(
              emoji,
              style: TextStyle(fontSize: width * 0.06),
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConstants.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.04,
                  ),
                ),
                if (mood.note != null && mood.note!.isNotEmpty)
                  Text(
                    mood.note!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppConstants.textSecondaryColor,
                      fontSize: width * 0.035,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            color: AppConstants.accentColor,
            tooltip: 'Share to Story',
            onPressed: () {
              final note = (mood.note != null && mood.note!.isNotEmpty) ? '\nNote: ${mood.note!}' : '';
              final shareText = 'Mood Check-in: $emoji $label$note\n— via MoodMate';
              Share.share(shareText);
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _saveMood() {
    if (selectedMood != null) {
      context.read<MoodBloc>().add(
        SaveMoodEntry(
          mood: selectedMood!,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        ),
      );
      
      _noteController.clear();
      setState(() {
        selectedMood = null;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Mood saved successfully!'),
          backgroundColor: AppConstants.successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
        ),
      );
    }
  }
} 
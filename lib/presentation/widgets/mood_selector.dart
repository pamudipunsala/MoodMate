import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/mood_entry.dart';

class MoodSelector extends StatelessWidget {
  final MoodType? selectedMood;
  final Function(MoodType) onMoodSelected;

  const MoodSelector({
    super.key,
    this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          'How are you feeling today?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppConstants.textPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.05,
          ),
        ),
        SizedBox(height: height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: MoodType.values.map((mood) {
            return _MoodOption(
              mood: mood,
              isSelected: selectedMood == mood,
              onTap: () => onMoodSelected(mood),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MoodOption extends StatelessWidget {
  final MoodType mood;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodOption({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  String get _emoji {
    switch (mood) {
      case MoodType.sad:
        return '😢';
      case MoodType.neutral:
        return '😐';
      case MoodType.happy:
        return '😊';
    }
  }

  String get _label {
    switch (mood) {
      case MoodType.sad:
        return 'Sad';
      case MoodType.neutral:
        return 'Okay';
      case MoodType.happy:
        return 'Happy';
    }
  }

  Color get _backgroundColor {
    if (!isSelected) return AppConstants.surfaceColor;
    
    switch (mood) {
      case MoodType.sad:
        return AppConstants.sadColor;
      case MoodType.neutral:
        return AppConstants.neutralColor;
      case MoodType.happy:
        return AppConstants.happyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animationMedium,
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: isSelected ? AppConstants.mediumShadow : AppConstants.softShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _emoji,
              style: TextStyle(fontSize: width * 0.12),
            ),
            SizedBox(height: height * 0.01),
            Text(
              _label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppConstants.textPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: width * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
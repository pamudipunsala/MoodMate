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
    return Column(
      children: [
        Text(
          'How are you feeling today?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppConstants.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacingL),
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animationMedium,
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          boxShadow: isSelected ? AppConstants.mediumShadow : AppConstants.softShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _emoji,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              _label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppConstants.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
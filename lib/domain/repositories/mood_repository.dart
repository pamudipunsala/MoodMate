import '../entities/mood_entry.dart';

abstract class MoodRepository {
  Future<List<MoodEntry>> getMoodEntries();
  Future<void> saveMoodEntry(MoodEntry moodEntry);
  Future<MoodEntry?> getTodayMood();
  Future<List<MoodEntry>> getMoodEntriesByDateRange(DateTime start, DateTime end);
} 
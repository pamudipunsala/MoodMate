import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry_model.dart';
import '../../core/constants/app_constants.dart';

abstract class MoodLocalDataSource {
  Future<List<MoodEntryModel>> getMoodEntries();
  Future<void> saveMoodEntry(MoodEntryModel moodEntry);
  Future<MoodEntryModel?> getTodayMood();
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  final SharedPreferences sharedPreferences;

  MoodLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<MoodEntryModel>> getMoodEntries() async {
    final String? moodEntriesJson = sharedPreferences.getString(AppConstants.moodEntriesKey);
    if (moodEntriesJson != null) {
      final List<dynamic> moodEntriesList = json.decode(moodEntriesJson);
      return moodEntriesList
          .map((json) => MoodEntryModel.fromJson(json))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveMoodEntry(MoodEntryModel moodEntry) async {
    final List<MoodEntryModel> existingEntries = await getMoodEntries();
    existingEntries.add(moodEntry);
    
    final List<Map<String, dynamic>> entriesJson = existingEntries
        .map((entry) => entry.toJson())
        .toList();
    
    await sharedPreferences.setString(
      AppConstants.moodEntriesKey,
      json.encode(entriesJson),
    );
  }

  @override
  Future<MoodEntryModel?> getTodayMood() async {
    final List<MoodEntryModel> entries = await getMoodEntries();
    final DateTime today = DateTime.now();
    
    for (final entry in entries) {
      final DateTime entryDate = DateTime(
        entry.timestamp.year,
        entry.timestamp.month,
        entry.timestamp.day,
      );
      final DateTime todayDate = DateTime(
        today.year,
        today.month,
        today.day,
      );
      
      if (entryDate.isAtSameMomentAs(todayDate)) {
        return entry;
      }
    }
    return null;
  }
} 
import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

class GetMoodEntries {
  final MoodRepository repository;

  GetMoodEntries(this.repository);

  Future<List<MoodEntry>> call() async {
    return await repository.getMoodEntries();
  }
}

class SaveMoodEntry {
  final MoodRepository repository;

  SaveMoodEntry(this.repository);

  Future<void> call(MoodEntry moodEntry) async {
    return await repository.saveMoodEntry(moodEntry);
  }
}

class GetTodayMood {
  final MoodRepository repository;

  GetTodayMood(this.repository);

  Future<MoodEntry?> call() async {
    return await repository.getTodayMood();
  }
}

class GetMoodEntriesByDateRange {
  final MoodRepository repository;

  GetMoodEntriesByDateRange(this.repository);

  Future<List<MoodEntry>> call(DateTime start, DateTime end) async {
    return await repository.getMoodEntriesByDateRange(start, end);
  }
} 
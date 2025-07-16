import '../../domain/entities/mood_entry.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_local_datasource.dart';
import '../models/mood_entry_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl(this.localDataSource);

  @override
  Future<List<MoodEntry>> getMoodEntries() async {
    final List<MoodEntryModel> models = await localDataSource.getMoodEntries();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveMoodEntry(MoodEntry moodEntry) async {
    final MoodEntryModel model = MoodEntryModel.fromEntity(moodEntry);
    await localDataSource.saveMoodEntry(model);
  }

  @override
  Future<MoodEntry?> getTodayMood() async {
    final MoodEntryModel? model = await localDataSource.getTodayMood();
    return model?.toEntity();
  }

  @override
  Future<List<MoodEntry>> getMoodEntriesByDateRange(DateTime start, DateTime end) async {
    final List<MoodEntry> allEntries = await getMoodEntries();
    return allEntries.where((entry) {
      return entry.timestamp.isAfter(start.subtract(const Duration(days: 1))) &&
             entry.timestamp.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }
} 
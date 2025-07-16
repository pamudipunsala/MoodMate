import '../../domain/entities/mood_entry.dart';

class MoodEntryModel {
  final String id;
  final int moodIndex;
  final DateTime timestamp;
  final String? note;

  const MoodEntryModel({
    required this.id,
    required this.moodIndex,
    required this.timestamp,
    this.note,
  });

  factory MoodEntryModel.fromEntity(MoodEntry entity) {
    return MoodEntryModel(
      id: entity.id,
      moodIndex: entity.mood.index,
      timestamp: entity.timestamp,
      note: entity.note,
    );
  }

  MoodEntry toEntity() {
    return MoodEntry(
      id: id,
      mood: MoodType.values[moodIndex],
      timestamp: timestamp,
      note: note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moodIndex': moodIndex,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
    };
  }

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      id: json['id'] as String,
      moodIndex: json['moodIndex'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String?,
    );
  }
} 
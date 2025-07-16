import 'package:equatable/equatable.dart';

enum MoodType {
  sad,
  neutral,
  happy,
}

class MoodEntry extends Equatable {
  final String id;
  final MoodType mood;
  final DateTime timestamp;
  final String? note;

  const MoodEntry({
    required this.id,
    required this.mood,
    required this.timestamp,
    this.note,
  });

  @override
  List<Object?> get props => [id, mood, timestamp, note];

  MoodEntry copyWith({
    String? id,
    MoodType? mood,
    DateTime? timestamp,
    String? note,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
    );
  }
} 
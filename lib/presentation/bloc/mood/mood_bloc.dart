import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/mood_entry.dart';
import '../../../domain/usecases/mood_usecases.dart' as mood_usecases;

// Events
abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoodEntries extends MoodEvent {}

class SaveMoodEntry extends MoodEvent {
  final MoodType mood;
  final String? note;

  const SaveMoodEntry({
    required this.mood,
    this.note,
  });

  @override
  List<Object?> get props => [mood, note];
}

class LoadTodayMood extends MoodEvent {}

// States
abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object?> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<MoodEntry> moodEntries;
  final MoodEntry? todayMood;

  const MoodLoaded({
    required this.moodEntries,
    this.todayMood,
  });

  @override
  List<Object?> get props => [moodEntries, todayMood];

  MoodLoaded copyWith({
    List<MoodEntry>? moodEntries,
    MoodEntry? todayMood,
  }) {
    return MoodLoaded(
      moodEntries: moodEntries ?? this.moodEntries,
      todayMood: todayMood ?? this.todayMood,
    );
  }
}

class MoodError extends MoodState {
  final String message;

  const MoodError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final mood_usecases.GetMoodEntries getMoodEntries;
  final mood_usecases.SaveMoodEntry saveMoodEntryUseCase;
  final mood_usecases.GetTodayMood getTodayMood;

  MoodBloc({
    required this.getMoodEntries,
    required this.saveMoodEntryUseCase,
    required this.getTodayMood,
  }) : super(MoodInitial()) {
    on<LoadMoodEntries>(_onLoadMoodEntries);
    on<SaveMoodEntry>(_onSaveMoodEntry);
    on<LoadTodayMood>(_onLoadTodayMood);
  }

  Future<void> _onLoadMoodEntries(
    LoadMoodEntries event,
    Emitter<MoodState> emit,
  ) async {
    emit(MoodLoading());
    try {
      final moodEntries = await getMoodEntries();
      final todayMood = await getTodayMood();
      emit(MoodLoaded(
        moodEntries: moodEntries,
        todayMood: todayMood,
      ));
    } catch (e) {
      emit(MoodError(e.toString()));
    }
  }

  Future<void> _onSaveMoodEntry(
    SaveMoodEntry event,
    Emitter<MoodState> emit,
  ) async {
    try {
      final newMoodEntry = MoodEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        mood: event.mood,
        timestamp: DateTime.now(),
        note: event.note,
      );

      await saveMoodEntryUseCase.call(newMoodEntry);

      // Reload mood entries after saving
      final moodEntries = await getMoodEntries();
      final todayMood = await getTodayMood();
      
      emit(MoodLoaded(
        moodEntries: moodEntries,
        todayMood: todayMood,
      ));
    } catch (e) {
      emit(MoodError(e.toString()));
    }
  }

  Future<void> _onLoadTodayMood(
    LoadTodayMood event,
    Emitter<MoodState> emit,
  ) async {
    try {
      final todayMood = await getTodayMood();
      if (state is MoodLoaded) {
        final currentState = state as MoodLoaded;
        emit(currentState.copyWith(todayMood: todayMood));
      } else {
        final moodEntries = await getMoodEntries();
        emit(MoodLoaded(
          moodEntries: moodEntries,
          todayMood: todayMood,
        ));
      }
    } catch (e) {
      emit(MoodError(e.toString()));
    }
  }
} 
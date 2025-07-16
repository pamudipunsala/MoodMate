import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/quotes_usecases.dart' as quotes_usecases;

// Events
abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object?> get props => [];
}

class LoadRandomQuote extends QuotesEvent {}

class LoadQuoteOfTheDay extends QuotesEvent {}

// States
abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object?> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final String quote;
  final bool isQuoteOfTheDay;

  const QuotesLoaded({
    required this.quote,
    this.isQuoteOfTheDay = false,
  });

  @override
  List<Object?> get props => [quote, isQuoteOfTheDay];
}

class QuotesError extends QuotesState {
  final String message;

  const QuotesError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final quotes_usecases.GetRandomQuote getRandomQuote;
  final quotes_usecases.GetQuoteOfTheDay getQuoteOfTheDay;

  QuotesBloc({
    required this.getRandomQuote,
    required this.getQuoteOfTheDay,
  }) : super(QuotesInitial()) {
    on<LoadRandomQuote>(_onLoadRandomQuote);
    on<LoadQuoteOfTheDay>(_onLoadQuoteOfTheDay);
  }

  Future<void> _onLoadRandomQuote(
    LoadRandomQuote event,
    Emitter<QuotesState> emit,
  ) async {
    emit(QuotesLoading());
    try {
      final quote = await getRandomQuote();
      emit(QuotesLoaded(quote: quote, isQuoteOfTheDay: false));
    } catch (e) {
      emit(QuotesError(e.toString()));
    }
  }

  Future<void> _onLoadQuoteOfTheDay(
    LoadQuoteOfTheDay event,
    Emitter<QuotesState> emit,
  ) async {
    emit(QuotesLoading());
    try {
      final quote = await getQuoteOfTheDay();
      emit(QuotesLoaded(quote: quote, isQuoteOfTheDay: true));
    } catch (e) {
      emit(QuotesError(e.toString()));
    }
  }
} 
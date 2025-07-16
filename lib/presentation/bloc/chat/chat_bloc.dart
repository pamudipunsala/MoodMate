import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/usecases/chat_usecases.dart' as chat_usecases;

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatHistory extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class ClearChatHistory extends ChatEvent {}

// States
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  final bool isSending;

  const ChatLoaded({
    required this.messages,
    this.isSending = false,
  });

  @override
  List<Object?> get props => [messages, isSending];

  ChatLoaded copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final chat_usecases.GetChatHistory getChatHistory;
  final chat_usecases.SendMessage sendMessage;
  final chat_usecases.ClearChatHistory clearChatHistory;

  ChatBloc({
    required this.getChatHistory,
    required this.sendMessage,
    required this.clearChatHistory,
  }) : super(ChatInitial()) {
    on<LoadChatHistory>(_onLoadChatHistory);
    on<SendMessage>(_onSendMessage);
    on<ClearChatHistory>(_onClearChatHistory);
  }

  Future<void> _onLoadChatHistory(
    LoadChatHistory event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      final messages = await getChatHistory();
      emit(ChatLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      if (state is ChatLoaded) {
        final currentState = state as ChatLoaded;
        emit(currentState.copyWith(isSending: true));
      }

      final aiMessage = await sendMessage(event.message);
      
      if (state is ChatLoaded) {
        final currentState = state as ChatLoaded;
        final updatedMessages = List<ChatMessage>.from(currentState.messages);
        updatedMessages.add(aiMessage);
        emit(ChatLoaded(
          messages: updatedMessages,
          isSending: false,
        ));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onClearChatHistory(
    ClearChatHistory event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await clearChatHistory();
      emit(const ChatLoaded(messages: []));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
} 
import 'package:equatable/equatable.dart';

enum MessageType {
  user,
  ai,
}

class ChatMessage extends Equatable {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isLoading;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [id, content, type, timestamp, isLoading];

  ChatMessage copyWith({
    String? id,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isLoading,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isLoading: isLoading ?? this.isLoading,
    );
  }
} 
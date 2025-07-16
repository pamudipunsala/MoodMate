import '../../domain/entities/chat_message.dart';

class ChatMessageModel {
  final String id;
  final String content;
  final int typeIndex;
  final DateTime timestamp;
  final bool isLoading;

  const ChatMessageModel({
    required this.id,
    required this.content,
    required this.typeIndex,
    required this.timestamp,
    this.isLoading = false,
  });

  factory ChatMessageModel.fromEntity(ChatMessage entity) {
    return ChatMessageModel(
      id: entity.id,
      content: entity.content,
      typeIndex: entity.type.index,
      timestamp: entity.timestamp,
      isLoading: entity.isLoading,
    );
  }

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      content: content,
      type: MessageType.values[typeIndex],
      timestamp: timestamp,
      isLoading: isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'typeIndex': typeIndex,
      'timestamp': timestamp.toIso8601String(),
      'isLoading': isLoading,
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      typeIndex: json['typeIndex'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isLoading: json['isLoading'] as bool? ?? false,
    );
  }
} 
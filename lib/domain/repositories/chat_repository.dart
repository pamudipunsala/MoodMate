import '../entities/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getChatHistory();
  Future<void> saveChatMessage(ChatMessage message);
  Future<ChatMessage> sendMessage(String message);
  Future<void> clearChatHistory();
} 
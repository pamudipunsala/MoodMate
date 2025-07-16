import '../entities/chat_message.dart';
import '../repositories/chat_repository.dart';

class GetChatHistory {
  final ChatRepository repository;

  GetChatHistory(this.repository);

  Future<List<ChatMessage>> call() async {
    return await repository.getChatHistory();
  }
}

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<ChatMessage> call(String message) async {
    return await repository.sendMessage(message);
  }
}

class SaveChatMessage {
  final ChatRepository repository;

  SaveChatMessage(this.repository);

  Future<void> call(ChatMessage message) async {
    return await repository.saveChatMessage(message);
  }
}

class ClearChatHistory {
  final ChatRepository repository;

  ClearChatHistory(this.repository);

  Future<void> call() async {
    return await repository.clearChatHistory();
  }
} 
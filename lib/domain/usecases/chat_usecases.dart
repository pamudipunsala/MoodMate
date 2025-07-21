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
    print('SendMessage UseCase: Starting to process message: "$message"');
    try {
      final result = await repository.sendMessage(message);
      print('SendMessage UseCase: Successfully received response from repository');
      return result;
    } catch (e) {
      print('SendMessage UseCase: Error occurred: $e');
      rethrow;
    }
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
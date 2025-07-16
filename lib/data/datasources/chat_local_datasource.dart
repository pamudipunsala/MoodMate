import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message_model.dart';
import '../../core/constants/app_constants.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatMessageModel>> getChatHistory();
  Future<void> saveChatMessage(ChatMessageModel message);
  Future<void> clearChatHistory();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final SharedPreferences sharedPreferences;

  ChatLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ChatMessageModel>> getChatHistory() async {
    final String? chatHistoryJson = sharedPreferences.getString(AppConstants.chatHistoryKey);
    if (chatHistoryJson != null) {
      final List<dynamic> chatHistoryList = json.decode(chatHistoryJson);
      return chatHistoryList
          .map((json) => ChatMessageModel.fromJson(json))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveChatMessage(ChatMessageModel message) async {
    final List<ChatMessageModel> existingMessages = await getChatHistory();
    existingMessages.add(message);
    
    final List<Map<String, dynamic>> messagesJson = existingMessages
        .map((msg) => msg.toJson())
        .toList();
    
    await sharedPreferences.setString(
      AppConstants.chatHistoryKey,
      json.encode(messagesJson),
    );
  }

  @override
  Future<void> clearChatHistory() async {
    await sharedPreferences.remove(AppConstants.chatHistoryKey);
  }
} 
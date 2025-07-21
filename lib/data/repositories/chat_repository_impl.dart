import 'package:uuid/uuid.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;
  final Uuid uuid;

  ChatRepositoryImpl({
    required this.localDataSource,
    required this.uuid,
  });

  @override
  Future<List<ChatMessage>> getChatHistory() async {
    final List<ChatMessageModel> models = await localDataSource.getChatHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveChatMessage(ChatMessage message) async {
    final ChatMessageModel model = ChatMessageModel.fromEntity(message);
    await localDataSource.saveChatMessage(model);
  }

  @override
  Future<ChatMessage> sendMessage(String message) async {
    print('ChatRepository: Starting to send message: "$message"');
    // Save user message
    final userMessage = ChatMessage(
      id: uuid.v4(),
      content: message,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );
    print('ChatRepository: Saving user message with ID: ${userMessage.id}');
    await saveChatMessage(userMessage);

    // Get AI response using local logic (simulate AI)
    final aiResponse = _getLocalAIReply(message);
    print('ChatRepository: Local AI response: "$aiResponse"');

    // Save AI message
    final aiMessage = ChatMessage(
      id: uuid.v4(),
      content: aiResponse,
      type: MessageType.ai,
      timestamp: DateTime.now(),
    );
    print('ChatRepository: Saving AI message with ID: ${aiMessage.id}');
    await saveChatMessage(aiMessage);

    print('ChatRepository: Returning AI message');
    return aiMessage;
  }

  String _getLocalAIReply(String message) {
    // You can call your expanded keyword logic here, or delegate to a helper
    // For now, just a fallback
    return 'Thank you for sharing. I’m here to listen.';
  }

  @override
  Future<void> clearChatHistory() async {
    await localDataSource.clearChatHistory();
  }
} 
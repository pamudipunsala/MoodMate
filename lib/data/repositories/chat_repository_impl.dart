import 'package:uuid/uuid.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;
  final ChatRemoteDataSource remoteDataSource;
  final Uuid uuid;

  ChatRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
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
    // Save user message
    final userMessage = ChatMessage(
      id: uuid.v4(),
      content: message,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );
    await saveChatMessage(userMessage);

    // Get AI response
    final aiResponse = await remoteDataSource.sendMessage(message);
    
    // Save AI message
    final aiMessage = ChatMessage(
      id: uuid.v4(),
      content: aiResponse,
      type: MessageType.ai,
      timestamp: DateTime.now(),
    );
    await saveChatMessage(aiMessage);

    return aiMessage;
  }

  @override
  Future<void> clearChatHistory() async {
    await localDataSource.clearChatHistory();
  }
} 
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

abstract class ChatRemoteDataSource {
  Future<String> sendMessage(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;
  final String apiKey;

  ChatRemoteDataSourceImpl({
    required this.client,
    required this.apiKey,
  });

  @override
  Future<String> sendMessage(String message) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.openAIBaseUrl}/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': AppConstants.openAIModel,
          'messages': [
            {
              'role': 'system',
              'content': 'You are a kind and emotionally supportive friend. Provide empathetic, comforting responses to help people feel better. Keep responses warm, understanding, and encouraging.',
            },
            {
              'role': 'user',
              'content': message,
            },
          ],
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content'] as String;
      } else {
        throw Exception('Failed to get response from OpenAI');
      }
    } catch (e) {
      // Fallback response for offline or error scenarios
      return _getFallbackResponse(message);
    }
  }

  String _getFallbackResponse(String message) {
    final fallbackResponses = [
      "I understand you're going through a tough time. Remember, it's okay to feel this way, and you're not alone.",
      "Thank you for sharing that with me. Your feelings are valid, and I'm here to listen.",
      "I hear you, and I want you to know that you're doing better than you think. Take it one moment at a time.",
      "It sounds like you're having a difficult day. Remember that this feeling won't last forever, and you have the strength to get through this.",
      "I'm here for you. Sometimes just talking about what's on your mind can help. What else would you like to share?",
    ];
    
    // Simple hash-based selection for consistent responses
    final hash = message.hashCode.abs();
    return fallbackResponses[hash % fallbackResponses.length];
  }
} 
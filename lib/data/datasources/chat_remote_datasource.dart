import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config/api_config.dart';
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
    // Local keyword-based AI logic (free, offline)
    final lowerMessage = message.toLowerCase();
    await Future.delayed(const Duration(milliseconds: 700));
    if (lowerMessage.contains('happy') || lowerMessage.contains('good') || lowerMessage.contains('great') || lowerMessage.contains('excellent') || lowerMessage.contains('wonderful') || lowerMessage.contains('amazing')) {
      return 'I can sense positive energy in your message! Your happiness is contagious. Keep spreading that joy! 😊';
    }
    if (lowerMessage.contains('sad') || lowerMessage.contains('unhappy') || lowerMessage.contains('bad') || lowerMessage.contains('terrible') || lowerMessage.contains('awful') || lowerMessage.contains('depressed') || lowerMessage.contains('miserable') || lowerMessage.contains('upset')) {
      return 'I hear that you\'re going through a difficult time. Remember, it\'s okay to feel this way, and you\'re not alone. Your feelings are valid. 💙';
    }
    if (lowerMessage.contains('?') || lowerMessage.contains('why') || lowerMessage.contains('how') || lowerMessage.contains('what')) {
      return 'That\'s an interesting question! I\'m here to help you explore your thoughts and feelings. What\'s on your mind? 🤔';
    }
    if (lowerMessage.contains('stress') || lowerMessage.contains('anxiety') || lowerMessage.contains('worried') || lowerMessage.contains('nervous') || lowerMessage.contains('overwhelmed')) {
      return 'I understand stress and anxiety can be really challenging. Take a deep breath. You\'re doing better than you think. 🌸';
    }
    return 'Thank you for sharing that with me. I\'m here to listen and support you. How are you feeling right now? 💭';
  }
} 
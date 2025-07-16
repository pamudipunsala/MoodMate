import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == MessageType.user;
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isUser ? AppConstants.spacingXL : AppConstants.spacingM,
          right: isUser ? AppConstants.spacingM : AppConstants.spacingXL,
          top: AppConstants.spacingS,
          bottom: AppConstants.spacingS,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingS,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppConstants.primaryColor : AppConstants.surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppConstants.borderRadiusM),
            topRight: const Radius.circular(AppConstants.borderRadiusM),
            bottomLeft: Radius.circular(isUser ? AppConstants.borderRadiusM : AppConstants.borderRadiusS),
            bottomRight: Radius.circular(isUser ? AppConstants.borderRadiusS : AppConstants.borderRadiusM),
          ),
          boxShadow: AppConstants.softShadow,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isLoading)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppConstants.textSecondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingS),
                  Text(
                    'AI is typing...',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.textSecondaryColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )
            else
              Text(
                message.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isUser ? AppConstants.textPrimaryColor : AppConstants.textPrimaryColor,
                ),
              ),
            const SizedBox(height: AppConstants.spacingXS),
            Text(
              _formatTime(message.timestamp),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppConstants.textSecondaryColor,
                fontSize: AppConstants.fontSizeSmall - 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
} 
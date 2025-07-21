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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isUser = message.type == MessageType.user;
    final theme = Theme.of(context);
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isUser ? width * 0.08 : width * 0.04,
          right: isUser ? width * 0.04 : width * 0.08,
          top: height * 0.005,
          bottom: height * 0.005,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isUser
                ? [AppConstants.primaryColor, AppConstants.primaryColor.withOpacity(0.8)]
                : [AppConstants.surfaceColor, AppConstants.backgroundColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.02),
            topRight: Radius.circular(width * 0.02),
            bottomLeft: Radius.circular(isUser ? width * 0.02 : width * 0.01),
            bottomRight: Radius.circular(isUser ? width * 0.01 : width * 0.02),
          ),
          boxShadow: [
            BoxShadow(
              color: isUser 
                  ? AppConstants.primaryColor.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: width * 0.75,
          minWidth: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isLoading)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: width * 0.04,
                    height: width * 0.04,
                    child: CircularProgressIndicator(
                      strokeWidth: width * 0.005,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppConstants.textSecondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Flexible(
                    child: Text(
                    'AI is typing...',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppConstants.textSecondaryColor,
                      fontStyle: FontStyle.italic,
                      fontSize: width * 0.035,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            else
              Flexible(
                child: Text(
                  message.content.isNotEmpty ? message.content : '[No message]',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isUser ? AppConstants.textPrimaryColor : AppConstants.textPrimaryColor,
                  fontSize: width * 0.035,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            SizedBox(height: height * 0.005),
            Text(
              message.timestamp != null ? _formatTime(message.timestamp) : '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppConstants.textSecondaryColor,
                fontSize: width * 0.03,
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
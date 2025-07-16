import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../bloc/chat/chat_bloc.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChatHistory());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
        backgroundColor: AppConstants.surfaceColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearChat,
            tooltip: 'Clear chat',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildWelcomeMessage(),
          Expanded(
            child: _buildChatMessages(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.spacingM),
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.psychology,
            color: AppConstants.primaryColor,
            size: 24,
          ),
          const SizedBox(width: AppConstants.spacingS),
          Expanded(
            child: Text(
              'I\'m here to listen and support you. Share what\'s on your mind.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.textPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoaded) {
          if (state.messages.isEmpty) {
            return _buildEmptyState();
          }
          
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return MessageBubble(message: message);
            },
          );
        } else if (state is ChatError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppConstants.errorColor,
                ),
                const SizedBox(height: AppConstants.spacingM),
                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConstants.textPrimaryColor,
                  ),
                ),
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppConstants.textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingL),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppConstants.primaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),
          Text(
            'Start a conversation',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppConstants.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            'I\'m here to listen and provide emotional support.\nShare what\'s on your mind.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final isSending = state is ChatLoaded && state.isSending;
        
        return Container(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          decoration: BoxDecoration(
            color: AppConstants.surfaceColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  enabled: !isSending,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: isSending ? 'AI is typing...' : 'Type your message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppConstants.backgroundColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingM,
                      vertical: AppConstants.spacingS,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingS),
              Container(
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                ),
                child: IconButton(
                  onPressed: isSending ? null : _sendMessage,
                  icon: isSending
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppConstants.textPrimaryColor,
                            ),
                          ),
                        )
                      : const Icon(Icons.send),
                  color: AppConstants.textPrimaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessage(message));
      _messageController.clear();
      
      // Scroll to bottom after sending message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear all messages? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ChatBloc>().add(ClearChatHistory());
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
} 
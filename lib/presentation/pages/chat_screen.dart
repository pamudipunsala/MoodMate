import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class SimpleChatScreen extends StatefulWidget {
  const SimpleChatScreen({Key? key}) : super(key: key);

  @override
  State<SimpleChatScreen> createState() => _SimpleChatScreenState();
}

class _SimpleChatScreenState extends State<SimpleChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'content': text});
      // Simple AI reply
      _messages.add({'role': 'ai', 'content': _getAIReply(text)});
      _controller.clear();
    });
  }

  String _getAIReply(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('happy') || lower.contains('joy') || lower.contains('excited') || lower.contains('great')) {
      return 'I can sense positive energy! 😊 That’s wonderful!';
    } else if (lower.contains('won') || lower.contains('promotion') || lower.contains('success') || lower.contains('passed') || lower.contains('accomplished') || lower.contains('proud') || lower.contains('improved')) {
      return 'Congratulations on your achievement! 🎉 You should be proud of yourself!';
    } else if (lower.contains('grateful') || lower.contains('thankful')) {
      return 'Gratitude is a wonderful feeling. It’s great to hear you’re feeling this way!';
    } else if (lower.contains('good day') || lower.contains('great day') || lower.contains('fun') || lower.contains('enjoyed') || lower.contains('relaxed') || lower.contains('peaceful')) {
      return 'That sounds like a lovely experience! I’m glad you had a good time.';
    } else if (lower.contains('motivated') || lower.contains('inspired')) {
      return 'That’s awesome! Keep up the positive energy!';
    } else if (lower.contains('sad') || lower.contains('down') || lower.contains('unhappy') || lower.contains('depressed')) {
      return 'I hear that you’re feeling sad. Remember, it’s okay to feel this way. I’m here for you.';
    } else if (lower.contains('anxious') || lower.contains('nervous') || lower.contains('worried') || lower.contains('scared')) {
      return 'Anxiety can be tough. Try taking a few deep breaths. I’m here for you.';
    } else if (lower.contains('angry') || lower.contains('mad') || lower.contains('frustrated')) {
      return 'It’s normal to feel angry sometimes. Would you like to talk more about what made you feel this way?';
    } else if (lower.contains('hurt') || lower.contains('pain') || lower.contains('injured')) {
      return 'I’m sorry you’re feeling hurt. If it’s physical pain, please consider reaching out to someone nearby or a professional.';
    } else if (lower.contains('lonely') || lower.contains('alone')) {
      return 'Feeling lonely can be hard. Remember, you’re not alone. I’m here to listen.';
    } else if (lower.contains('stressed') || lower.contains('overwhelmed') || lower.contains('pressure')) {
      return 'Stress can be overwhelming. Try to take a short break or do something you enjoy. I’m here for you.';
    } else if (lower.contains('tired') || lower.contains('exhausted') || lower.contains('sleepy')) {
      return 'It sounds like you’re tired. Rest is important. Make sure to take care of yourself.';
    } else if (lower.contains('fail') || lower.contains('failure') || (lower.contains('exam') && lower.contains('bad'))) {
      return 'It’s okay to not succeed every time. What matters is that you tried your best.';
    } else if (lower.contains('breakup') || lower.contains('broken up') || lower.contains('heartbreak')) {
      return 'Breakups can be really tough. Give yourself time to heal. I’m here if you want to talk.';
    } else if (lower.contains('fight') || lower.contains('argument') || lower.contains('conflict')) {
      return 'Conflicts can be hard. Would you like to talk more about what happened?';
    } else if (lower.contains('work') || lower.contains('job')) {
      return 'Work can be stressful sometimes. Remember to take breaks and care for your well-being.';
    } else if (lower.contains('school') || lower.contains('study') || lower.contains('homework')) {
      return 'School can be challenging. Remember to pace yourself and ask for help if you need it.';
    } else if (lower.contains('family')) {
      return 'Family relationships can be complex. I’m here if you want to share more.';
    } else if (lower.contains('friend')) {
      return 'Friends are important. If you’re having trouble with a friend, I’m here to listen.';
    } else if (lower.contains('hello') || lower.contains('hi') || lower.contains('hey')) {
      return 'Hello! How can I support you today?';
    } else if (lower.contains('help') || lower.contains('support')) {
      return 'I’m here to listen and help. What’s on your mind?';
    } else if (lower.contains('thank')) {
      return 'You’re welcome! I’m always here if you need to talk.';
    } else if (lower.contains('love')) {
      return 'Love is a powerful feeling. Would you like to talk more about it?';
    } else if (lower.contains('scared') || lower.contains('afraid')) {
      return 'It’s okay to feel scared sometimes. You’re not alone.';
    } else if (lower.contains('lost')) {
      return 'Feeling lost can be tough. Take things one step at a time. I’m here for you.';
    } else if (lower.contains('motivate') || lower.contains('motivation')) {
      return 'You are stronger than you think! Keep going, you’ve got this.';
    } else {
      return 'Thank you for sharing. I’m here to listen.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(width * 0.04),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: height * 0.005),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.012,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? AppConstants.primaryColor : AppConstants.surfaceColor,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Text(
                      msg['content'] ?? '',
                      style: TextStyle(
                        color: isUser ? AppConstants.textPrimaryColor : AppConstants.textSecondaryColor,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppConstants.surfaceColor,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(
                        fontSize: width * 0.035,
                        color: AppConstants.textSecondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.012,
                      ),
                    ),
                    style: TextStyle(fontSize: width * 0.035),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: width * 0.02),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    size: width * 0.06,
                  ),
                  color: AppConstants.primaryColor,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
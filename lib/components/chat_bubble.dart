import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theresolutemind/themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
        decoration: BoxDecoration(
            color: isCurrentUser
                ? Colors.blue
                : (isDarkMode ? Colors.grey.shade900 : Colors.grey.shade500),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Text(message, style: const TextStyle(color: Colors.white)));
  }
}

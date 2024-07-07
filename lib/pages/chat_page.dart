import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:theresolutemind/components/chat_bubble.dart';
import 'package:theresolutemind/components/my_textfield.dart';
import 'package:theresolutemind/services/auth/auth_service.dart';
import 'package:theresolutemind/services/chat/chat_services.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String senderId;
  final String recieverId;
  ChatPage(
      {super.key,
      required this.recieverEmail,
      required this.recieverId,
      required this.senderId});

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUSerInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(recieverId, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ChatBubble(
                  message: data['message'], isCurrentUser: isCurrentUser),
            ]));
  }

  Widget _buildUSerInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
            controller: _messageController,
            hintText: "Type a message",
            obscureText: false,
          )),
          Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(50)),
              margin: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.arrow_upward),
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}

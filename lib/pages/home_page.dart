import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:theresolutemind/components/user_tile.dart';
import 'package:theresolutemind/pages/chat_page.dart';
import 'package:theresolutemind/services/auth/auth_service.dart';
import 'package:theresolutemind/components/my_drawer.dart';
import 'package:theresolutemind/services/chat/chat_services.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
        drawer: MyDrawer(),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList());
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    String? currentUserEmail = _authService.getCurrentUser()!.email;
    if (currentUserEmail == "kritimonga1407@gmail.com") {
      return UserTile(
        text: userData["username"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => ChatPage(
                    recieverEmail: userData["username"]!,
                    recieverId: userData["uid"]!,
                    senderId: _authService.getCurrentUser()!.uid,
                  )),
            ),
          );
        },
      );
    } else {
      if (userData["email"] == "kritimonga1407@gmail.com") {
        return UserTile(
          text: userData["username"],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ChatPage(
                      recieverEmail: userData["username"]!,
                      recieverId: userData["uid"]!,
                      senderId: _authService.getCurrentUser()!.uid,
                    )),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    }
  }
}

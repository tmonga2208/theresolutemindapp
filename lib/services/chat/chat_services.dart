import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:theresolutemind/models/message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data() as Map<String, dynamic>;
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        recieverID: receiverID,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatID = ids.join("_");
    await _firestore
        .collection("chat_rooms")
        .doc(chatID)
        .collection("messages")
        .add(newMessage.toMap());

    // Fetch receiver's FCM token from Firestore
    var tokenDoc = await _firestore.collection("users").doc(receiverID).get();
    var token = tokenDoc.data()?['fcmToken'];
    if (token != null) {
      // Send notification (Consider moving this to a cloud function for production)
      await sendNotification(token, currentUserEmail, message);
    }
  }

  Future<void> sendNotification(
      String token, String senderEmail, String message) async {
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var header = {
      "Content-Type": "application/json",
      "Authorization": "key=232873952071",
    };
    var request = {
      "notification": {
        "title": "New Message from $senderEmail",
        "body": message,
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    var response =
        await http.post(url, headers: header, body: json.encode(request));
    print('FCM request sent: ${response.body}');
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatID = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatID)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots();
  }
}

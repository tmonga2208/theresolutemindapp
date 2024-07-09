import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAPI {
  final _FirebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNoifications() async {
    NotificationSettings settings = await _FirebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    _FirebaseMessaging.getToken().then((value) {
      print('Token: $value');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
    });
  }
}

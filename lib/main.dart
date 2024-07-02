import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:theresolutemind/auth/auth_gate.dart';
import 'package:theresolutemind/firebase_options.dart';
import 'package:theresolutemind/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: lightMode,
    );
  }
}

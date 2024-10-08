// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCFEePmgoye2Dbp4Y5xaMtTkLZA5JnXiKI',
    appId: '1:232873952071:web:e055783b9f03cc3dc28262',
    messagingSenderId: '232873952071',
    projectId: 'blog-website-3eee7',
    authDomain: 'blog-website-3eee7.firebaseapp.com',
    databaseURL: 'https://blog-website-3eee7-default-rtdb.firebaseio.com',
    storageBucket: 'blog-website-3eee7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJvhh3Ebw3yK7-JUMs5JRvOflS_cySgMc',
    appId: '1:232873952071:android:7efe7350b6c0adc2c28262',
    messagingSenderId: '232873952071',
    projectId: 'blog-website-3eee7',
    databaseURL: 'https://blog-website-3eee7-default-rtdb.firebaseio.com',
    storageBucket: 'blog-website-3eee7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf4ptKPlj7gyUwq11ej3z6Dt1Pp8E9vYk',
    appId: '1:232873952071:ios:348ca336290e3331c28262',
    messagingSenderId: '232873952071',
    projectId: 'blog-website-3eee7',
    databaseURL: 'https://blog-website-3eee7-default-rtdb.firebaseio.com',
    storageBucket: 'blog-website-3eee7.appspot.com',
    iosClientId: '232873952071-dbbbmjhjjhuef1ouu6vlnrqfucgl3p1q.apps.googleusercontent.com',
    iosBundleId: 'com.example.theresolutemind',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBf4ptKPlj7gyUwq11ej3z6Dt1Pp8E9vYk',
    appId: '1:232873952071:ios:348ca336290e3331c28262',
    messagingSenderId: '232873952071',
    projectId: 'blog-website-3eee7',
    databaseURL: 'https://blog-website-3eee7-default-rtdb.firebaseio.com',
    storageBucket: 'blog-website-3eee7.appspot.com',
    iosClientId: '232873952071-dbbbmjhjjhuef1ouu6vlnrqfucgl3p1q.apps.googleusercontent.com',
    iosBundleId: 'com.example.theresolutemind',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCFEePmgoye2Dbp4Y5xaMtTkLZA5JnXiKI',
    appId: '1:232873952071:web:2ff18311396cbf78c28262',
    messagingSenderId: '232873952071',
    projectId: 'blog-website-3eee7',
    authDomain: 'blog-website-3eee7.firebaseapp.com',
    databaseURL: 'https://blog-website-3eee7-default-rtdb.firebaseio.com',
    storageBucket: 'blog-website-3eee7.appspot.com',
  );
}

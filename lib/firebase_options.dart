// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDp06FabGkP-3xHjmonM9h7U6AordhkG64',
    appId: '1:816088408558:web:6dbf2a5ce6baecb5dd6eff',
    messagingSenderId: '816088408558',
    projectId: 'iris-412014',
    authDomain: 'iris-412014.firebaseapp.com',
    storageBucket: 'iris-412014.appspot.com',
    measurementId: 'G-SZN5Y5KS1J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOxLTbcJU7RMq3r4kBTI9gBsiD9sMNqzc',
    appId: '1:816088408558:android:73ef13001a1b8748dd6eff',
    messagingSenderId: '816088408558',
    projectId: 'iris-412014',
    storageBucket: 'iris-412014.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5RoRcsZcC6pbsuWFT80l9EhuUaHzqC7U',
    appId: '1:816088408558:ios:a7210d4a9fb4b20cdd6eff',
    messagingSenderId: '816088408558',
    projectId: 'iris-412014',
    storageBucket: 'iris-412014.appspot.com',
    androidClientId:
        '816088408558-hd3hqbonnmhiah19e1udpnfpk476upeb.apps.googleusercontent.com',
    iosClientId:
        '816088408558-m8j4ju4fklhoo76bf2850vm0vo1p2007.apps.googleusercontent.com',
    iosBundleId: 'com.example.irisFlutter',
  );
}
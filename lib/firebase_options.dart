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
        return macos;
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
    apiKey: 'AIzaSyDynlwZ9bJjg3iAdZyZrmxfXqspXsmx8_o',
    appId: '1:1063438940919:web:837cc36628a6c70f6d71f2',
    messagingSenderId: '1063438940919',
    projectId: 'reddit-56bf9',
    authDomain: 'reddit-56bf9.firebaseapp.com',
    storageBucket: 'reddit-56bf9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM2nj3RiPbb3J3U2ln7i_g0EjZeaXo2po',
    appId: '1:1063438940919:android:53fcc99e41faf4fe6d71f2',
    messagingSenderId: '1063438940919',
    projectId: 'reddit-56bf9',
    storageBucket: 'reddit-56bf9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaxcRR1EH4XF-VELkqUQoHUlkhiUS_4aI',
    appId: '1:1063438940919:ios:2136d5b85ed275926d71f2',
    messagingSenderId: '1063438940919',
    projectId: 'reddit-56bf9',
    storageBucket: 'reddit-56bf9.appspot.com',
    iosClientId: '1063438940919-tbeqobstjt00l2maulhp7bc0kg8lge7c.apps.googleusercontent.com',
    iosBundleId: 'com.example.reddit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaxcRR1EH4XF-VELkqUQoHUlkhiUS_4aI',
    appId: '1:1063438940919:ios:527e07a7297d304e6d71f2',
    messagingSenderId: '1063438940919',
    projectId: 'reddit-56bf9',
    storageBucket: 'reddit-56bf9.appspot.com',
    iosClientId: '1063438940919-5hn2reastp6eabdr3bqijvb49dse8icq.apps.googleusercontent.com',
    iosBundleId: 'com.example.reddit.RunnerTests',
  );
}
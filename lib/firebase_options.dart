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
    apiKey: 'AIzaSyDUGTcJFsGqVP5eL3gyBSOcUMae5ZRM-Sk',
    appId: '1:85146580525:web:fa01044fe0e7f77834eaa4',
    messagingSenderId: '85146580525',
    projectId: 'shopsync-d1c30',
    authDomain: 'shopsync-d1c30.firebaseapp.com',
    storageBucket: 'shopsync-d1c30.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2_F6eaBmSr6z6A5oWJ6hNXI_Mc3TtVPI',
    appId: '1:85146580525:android:23c8abdfe7828f3e34eaa4',
    messagingSenderId: '85146580525',
    projectId: 'shopsync-d1c30',
    storageBucket: 'shopsync-d1c30.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDz3--3tSludaR8AGC5205weWrvsXbKpI',
    appId: '1:85146580525:ios:4c2631cd182c027234eaa4',
    messagingSenderId: '85146580525',
    projectId: 'shopsync-d1c30',
    storageBucket: 'shopsync-d1c30.appspot.com',
    iosBundleId: 'com.example.shopsyncseller',
  );
}
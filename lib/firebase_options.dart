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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBZWpSjUQfosyLyuLR48qIJTAxK5Umbs1s',
    appId: '1:865454326616:web:4dfbb380535faecb151b2d',
    messagingSenderId: '865454326616',
    projectId: 'fuel-deliveryapp',
    authDomain: 'fuel-deliveryapp.firebaseapp.com',
    storageBucket: 'fuel-deliveryapp.appspot.com',
    measurementId: 'G-JT55ZRWE5B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDn6Jm17IuiSVAoZOin9J2kVxERA1O8Hus',
    appId: '1:865454326616:android:edbcd7ee266acce3151b2d',
    messagingSenderId: '865454326616',
    projectId: 'fuel-deliveryapp',
    storageBucket: 'fuel-deliveryapp.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZWpSjUQfosyLyuLR48qIJTAxK5Umbs1s',
    appId: '1:865454326616:web:8a4bac3ef9c9a862151b2d',
    messagingSenderId: '865454326616',
    projectId: 'fuel-deliveryapp',
    authDomain: 'fuel-deliveryapp.firebaseapp.com',
    storageBucket: 'fuel-deliveryapp.appspot.com',
    measurementId: 'G-TH5KXTLRVN',
  );
}

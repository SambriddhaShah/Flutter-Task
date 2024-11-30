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
    apiKey: 'AIzaSyB6cXMWj9oQ7cz5P2xbmydhNzLqPHgjLXU',
    appId: '1:393689127390:web:20dcab2d6e74113e75a54f',
    messagingSenderId: '393689127390',
    projectId: 'pushnotification-c4f53',
    authDomain: 'pushnotification-c4f53.firebaseapp.com',
    storageBucket: 'pushnotification-c4f53.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAypOrhB7XGhWMpIUitKVuPciCHC0dxrjg',
    appId: '1:393689127390:android:614a60a151a85fd175a54f',
    messagingSenderId: '393689127390',
    projectId: 'pushnotification-c4f53',
    storageBucket: 'pushnotification-c4f53.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZePN7ErTcpDayZ_DD4Cbjiy4kz5JKo7E',
    appId: '1:393689127390:ios:0f27f97d4388f26075a54f',
    messagingSenderId: '393689127390',
    projectId: 'pushnotification-c4f53',
    storageBucket: 'pushnotification-c4f53.firebasestorage.app',
    iosBundleId: 'com.example.lipstick',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZePN7ErTcpDayZ_DD4Cbjiy4kz5JKo7E',
    appId: '1:393689127390:ios:0f27f97d4388f26075a54f',
    messagingSenderId: '393689127390',
    projectId: 'pushnotification-c4f53',
    storageBucket: 'pushnotification-c4f53.firebasestorage.app',
    iosBundleId: 'com.example.lipstick',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB6cXMWj9oQ7cz5P2xbmydhNzLqPHgjLXU',
    appId: '1:393689127390:web:36a00f31de4f10a175a54f',
    messagingSenderId: '393689127390',
    projectId: 'pushnotification-c4f53',
    authDomain: 'pushnotification-c4f53.firebaseapp.com',
    storageBucket: 'pushnotification-c4f53.firebasestorage.app',
  );
}
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
    apiKey: 'AIzaSyAR5NPWYUaj_oEGSAL7V7tCUB_5uAEYRR4',
    appId: '1:317750935639:web:b92ced48f032631747a312',
    messagingSenderId: '317750935639',
    projectId: 'crudapp-17ac1',
    authDomain: 'crudapp-17ac1.firebaseapp.com',
    storageBucket: 'crudapp-17ac1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0KNA4rxfmVZocoBpEHsNkeKmqsOGOHnk',
    appId: '1:317750935639:android:47fb704893f63f5447a312',
    messagingSenderId: '317750935639',
    projectId: 'crudapp-17ac1',
    storageBucket: 'crudapp-17ac1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa8FwhEq4imVTiZUAwMbMpQw8a3D628YU',
    appId: '1:317750935639:ios:529bce392fe7d06647a312',
    messagingSenderId: '317750935639',
    projectId: 'crudapp-17ac1',
    storageBucket: 'crudapp-17ac1.appspot.com',
    iosClientId: '317750935639-het2u5k9l7ek8nomo1dfatqtfcllv26a.apps.googleusercontent.com',
    iosBundleId: 'com.example.crud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBa8FwhEq4imVTiZUAwMbMpQw8a3D628YU',
    appId: '1:317750935639:ios:529bce392fe7d06647a312',
    messagingSenderId: '317750935639',
    projectId: 'crudapp-17ac1',
    storageBucket: 'crudapp-17ac1.appspot.com',
    iosClientId: '317750935639-het2u5k9l7ek8nomo1dfatqtfcllv26a.apps.googleusercontent.com',
    iosBundleId: 'com.example.crud',
  );
}

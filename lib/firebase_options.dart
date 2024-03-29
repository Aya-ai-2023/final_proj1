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
    apiKey: 'AIzaSyALXfDVUbWt2b3w4wEI3Jm5flZEQGHNeh4',
    appId: '1:735664136437:web:98b50ba7eec53f4aebe5bc',
    messagingSenderId: '735664136437',
    projectId: 'shopify-application-335ac',
    authDomain: 'shopify-application-335ac.firebaseapp.com',
    storageBucket: 'shopify-application-335ac.appspot.com',
    measurementId: 'G-005KSZLSQY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFp2_iHREgtqhKyWe9Cn-7xmzEB_Rzz7o',
    appId: '1:735664136437:android:2b9c16d7f26b7c8cebe5bc',
    messagingSenderId: '735664136437',
    projectId: 'shopify-application-335ac',
    storageBucket: 'shopify-application-335ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB98FoUdDkK3xJvfLKjMXIklAoC1jTjLyE',
    appId: '1:735664136437:ios:25e127f2ab35c828ebe5bc',
    messagingSenderId: '735664136437',
    projectId: 'shopify-application-335ac',
    storageBucket: 'shopify-application-335ac.appspot.com',
    iosBundleId: 'com.example.finalProj',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB98FoUdDkK3xJvfLKjMXIklAoC1jTjLyE',
    appId: '1:735664136437:ios:9a498cf127312faeebe5bc',
    messagingSenderId: '735664136437',
    projectId: 'shopify-application-335ac',
    storageBucket: 'shopify-application-335ac.appspot.com',
    iosBundleId: 'com.example.finalProj.RunnerTests',
  );
}

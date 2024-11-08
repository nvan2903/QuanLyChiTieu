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
    apiKey: 'AIzaSyB5OsK2frhMvzN6QIHk0TAcygMG1djJO2Y',
    appId: '1:1006875186967:web:268b3129966c78d7c9c952',
    messagingSenderId: '1006875186967',
    projectId: 'moneymatedemo',
    authDomain: 'moneymatedemo.firebaseapp.com',
    storageBucket: 'moneymatedemo.appspot.com',
    measurementId: 'G-LE4BBVQJWY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY53sX9xYS_jwBL2Qb1a-GimdpwVF0uAE',
    appId: '1:1006875186967:android:0510e8f04c29f2fbc9c952',
    messagingSenderId: '1006875186967',
    projectId: 'moneymatedemo',
    storageBucket: 'moneymatedemo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANFJ94skvOEEOqFGpHKCWJFUKjW_Monqg',
    appId: '1:1006875186967:ios:e7ae3a6b912f1dccc9c952',
    messagingSenderId: '1006875186967',
    projectId: 'moneymatedemo',
    storageBucket: 'moneymatedemo.appspot.com',
    iosClientId: '1006875186967-njapgfph3l2b6k5079n7e5bdp3pfipb7.apps.googleusercontent.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB5OsK2frhMvzN6QIHk0TAcygMG1djJO2Y',
    appId: '1:1006875186967:web:8f6e823a907b2beac9c952',
    messagingSenderId: '1006875186967',
    projectId: 'moneymatedemo',
    authDomain: 'moneymatedemo.firebaseapp.com',
    storageBucket: 'moneymatedemo.appspot.com',
    measurementId: 'G-GN5CG90X4X',
  );

}
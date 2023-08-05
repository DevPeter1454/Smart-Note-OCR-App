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
    apiKey: 'AIzaSyDdyD1eCPCQNGAMXFfp-C7Wjv-Fkvcb7A4',
    appId: '1:187372280063:web:87d6f1a71ad7f0908e54ca',
    messagingSenderId: '187372280063',
    projectId: 'smart-notes-5682c',
    authDomain: 'smart-notes-5682c.firebaseapp.com',
    storageBucket: 'smart-notes-5682c.appspot.com',
    measurementId: 'G-0TTQ8DBVHR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6B6cFtzPRFqvvQ-QLeXLm-2_VIzqlIRo',
    appId: '1:187372280063:android:c66e471675b5f7928e54ca',
    messagingSenderId: '187372280063',
    projectId: 'smart-notes-5682c',
    storageBucket: 'smart-notes-5682c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaStP-vtqR_mYBBZMkXAH8JFB5ArBbWFM',
    appId: '1:187372280063:ios:72bfeddb71ba47158e54ca',
    messagingSenderId: '187372280063',
    projectId: 'smart-notes-5682c',
    storageBucket: 'smart-notes-5682c.appspot.com',
    iosClientId:
        '187372280063-gobuuje206go42vpm2q4vg1ta5pt4nff.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartnote',
  );
}

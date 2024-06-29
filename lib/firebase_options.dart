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
    apiKey: 'AIzaSyC2v9lcpb8GZpEEgJIVEuw02_2_dyjzaS8',
    appId: '1:688300191313:web:feb62126b68c64ab32d270',
    messagingSenderId: '688300191313',
    projectId: 'wcyclebd',
    authDomain: 'wcyclebd.firebaseapp.com',
    storageBucket: 'wcyclebd.appspot.com',
    measurementId: 'G-5V2QLPQR6S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC70GVg_7Y6vvxbbSMTc3zBJZ21SQecF5E',
    appId: '1:688300191313:android:d61d6fd797e152e232d270',
    messagingSenderId: '688300191313',
    projectId: 'wcyclebd',
    storageBucket: 'wcyclebd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnKwDfikX6-K1XwJDYL0mXZR5mtG7Est4',
    appId: '1:688300191313:ios:b5fe8b0f9cab2aab32d270',
    messagingSenderId: '688300191313',
    projectId: 'wcyclebd',
    storageBucket: 'wcyclebd.appspot.com',
    androidClientId: '688300191313-4hm4u0jm72ajetc1n2m43neuh7jkokfb.apps.googleusercontent.com',
    iosClientId: '688300191313-2id1ovg8rd94eqv2len035ujtsrnhm8i.apps.googleusercontent.com',
    iosBundleId: 'com.example.wcycleBd',
  );

}
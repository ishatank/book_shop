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
    apiKey: 'AIzaSyA5OveEUIlQhgwt6Kri-Mm42pfjj6AZlfo',
    appId: '1:318956009088:web:feb8c5a9b43b91d7f35865',
    messagingSenderId: '318956009088',
    projectId: 'book-shop-e3bc4',
    authDomain: 'book-shop-e3bc4.firebaseapp.com',
    storageBucket: 'book-shop-e3bc4.appspot.com',
    measurementId: 'G-R1CN3ZY0X2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAX2fCoAFB30eTSZKyWlJyuzM4PZKhXtyY',
    appId: '1:318956009088:android:c233986c3c485adef35865',
    messagingSenderId: '318956009088',
    projectId: 'book-shop-e3bc4',
    storageBucket: 'book-shop-e3bc4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOOmHKHi56IIoudrm4cnJoLWKPXZXhj7Y',
    appId: '1:318956009088:ios:d162081671a12b42f35865',
    messagingSenderId: '318956009088',
    projectId: 'book-shop-e3bc4',
    storageBucket: 'book-shop-e3bc4.appspot.com',
    iosBundleId: 'com.codeforany.bookGrocer',
  );
}

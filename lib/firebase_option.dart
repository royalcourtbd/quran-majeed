// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8UlVfxtnVqMmLkizYN5Vdwgp6s1sObsI',
    appId: '1:447465673833:android:8c3b8dad7db4f206',
    messagingSenderId: '447465673833',
    projectId: 'quranmazid-175716',
    databaseURL: 'https://quranmazid-175716.firebaseio.com',
    storageBucket: 'quranmazid-175716.appspot.com',
    androidClientId: "447465673833-u1544vdem9a2302vjoc8npts8bo7vdil.apps.googleusercontent.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCttBs56LtmmZLQQxZAItKdrUWanDIJVEU',
    appId: '1:110778210560:ios:ae873195c340f91b62bbe5',
    messagingSenderId: '447465673833',
    projectId: 'quranmazid-175716',
    databaseURL: 'https://quranmazid-175716.firebaseio.com',
    storageBucket: 'quranmazid-175716.appspot.com',
  );
}

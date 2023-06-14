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
    apiKey: 'AIzaSyCe0meHNGs8xC_o-r5GNPlMN_UecxicQr8',
    appId: '1:676022371548:web:a50e27183fbb9dd719a019',
    messagingSenderId: '676022371548',
    projectId: 'hr-system-app',
    authDomain: 'hr-system-app.firebaseapp.com',
    storageBucket: 'hr-system-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfzhjLUaalc_mCnQNE2ZltqC5G4e0m5dE',
    appId: '1:676022371548:android:84abe0567db05a9d19a019',
    messagingSenderId: '676022371548',
    projectId: 'hr-system-app',
    storageBucket: 'hr-system-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOCUcy30LBheEPMUu_6OPDcw6Wbyccqtk',
    appId: '1:676022371548:ios:d1ee8200cf2278ae19a019',
    messagingSenderId: '676022371548',
    projectId: 'hr-system-app',
    storageBucket: 'hr-system-app.appspot.com',
    iosClientId: '676022371548-bm45n8betift44j68h64qls8936ds6ur.apps.googleusercontent.com',
    iosBundleId: 'com.example.hrApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOCUcy30LBheEPMUu_6OPDcw6Wbyccqtk',
    appId: '1:676022371548:ios:4e08db623db1110019a019',
    messagingSenderId: '676022371548',
    projectId: 'hr-system-app',
    storageBucket: 'hr-system-app.appspot.com',
    iosClientId: '676022371548-7mnfu4vgarjjvul3tf4p43jk8kpri63q.apps.googleusercontent.com',
    iosBundleId: 'com.example.hrApp.RunnerTests',
  );
}

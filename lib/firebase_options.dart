import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB7Pyc5_6BpP84I-SfVQVCs0E05KJumybA',
    appId: '1:122558572656:web:19b6e32b8dbf50f0a46cb5',
    messagingSenderId: '122558572656',
    projectId: 'slymn-daef0',
    authDomain: 'slymn-daef0.firebaseapp.com',
    storageBucket: 'slymn-daef0.firebasestorage.app',
    measurementId: 'G-4JG6TTHVSX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTs5ds02KT-zapgliILpq1rUBfQyJyCtI',
    appId: '1:122558572656:android:2c03abe47ac0c201a46cb5',
    messagingSenderId: '122558572656',
    projectId: 'slymn-daef0',
    storageBucket: 'slymn-daef0.firebasestorage.app',
  );
}

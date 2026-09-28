// File generated for FlutterFire.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8Lixy-XF0V_UCTGCzUz0AEBzLgIP-7ik',
    appId: '1:567407553652:web:d510db5fa139b829b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    authDomain: 'sun-app-6c6af.firebaseapp.com',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    measurementId: 'G-R3BVP1XBXZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVzMyvPlxSNcr1TNJzmts5XdCg4YKTY40',
    appId: '1:567407553652:android:3bebbf4d3f7bda33b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADbYHlqshr5QBhF4EG6wizEhusFJbRRqY',
    appId: '1:567407553652:ios:4f2ed01919ea4797b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    iosBundleId: 'com.san.app.sanApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADbYHlqshr5QBhF4EG6wizEhusFJbRRqY',
    appId: '1:567407553652:ios:4f2ed01919ea4797b7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    iosBundleId: 'com.san.app.sanApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8Lixy-XF0V_UCTGCzUz0AEBzLgIP-7ik',
    appId: '1:567407553652:web:f6d1d4714fdb64abb7b521',
    messagingSenderId: '567407553652',
    projectId: 'sun-app-6c6af',
    authDomain: 'sun-app-6c6af.firebaseapp.com',
    storageBucket: 'sun-app-6c6af.firebasestorage.app',
    measurementId: 'G-VTQJ6BYFWX',
  );
}

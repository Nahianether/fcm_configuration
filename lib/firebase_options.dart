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
    apiKey: 'AIzaSyA8GT8oGiyfy45i3UdLX1kWFn1F3k_ZvEw',
    appId: '1:119734878735:web:882ad62c94e0551b01197a',
    messagingSenderId: '119734878735',
    projectId: 'fcm-new-ad4391375735565',
    authDomain: 'fcm-new-ad4391375735565.firebaseapp.com',
    storageBucket: 'fcm-new-ad4391375735565.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPtej2yFyxbc7DZLEvK-XskQSejtOMr2U',
    appId: '1:119734878735:android:d0182ce70caeeb7501197a',
    messagingSenderId: '119734878735',
    projectId: 'fcm-new-ad4391375735565',
    storageBucket: 'fcm-new-ad4391375735565.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOcOFOKHNs4uWsYBQsTIHJ1GaZe8RFiLU',
    appId: '1:119734878735:ios:235a7953baa3539201197a',
    messagingSenderId: '119734878735',
    projectId: 'fcm-new-ad4391375735565',
    storageBucket: 'fcm-new-ad4391375735565.appspot.com',
    iosClientId:
        '119734878735-2id1pn9bfpnnpreriimph5ran8301724.apps.googleusercontent.com',
    iosBundleId: 'com.example.fcmConfigAdnan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOcOFOKHNs4uWsYBQsTIHJ1GaZe8RFiLU',
    appId: '1:119734878735:ios:050096d0aa70051701197a',
    messagingSenderId: '119734878735',
    projectId: 'fcm-new-ad4391375735565',
    storageBucket: 'fcm-new-ad4391375735565.appspot.com',
    iosClientId:
        '119734878735-710b6etr17nrsom4jmrfrckcrbncigjg.apps.googleusercontent.com',
    iosBundleId: 'com.example.fcmConfigAdnan.RunnerTests',
  );
}

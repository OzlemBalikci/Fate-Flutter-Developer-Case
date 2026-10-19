// CI-only stub. Real file: `flutterfire configure` → lib/firebase_options.dart (not committed).
// ignore_for_file: type=lint

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
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'ci-stub',
    appId: '1:000000000000:web:00000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ci-stub',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'ci-stub',
    appId: '1:000000000000:android:00000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ci-stub',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'ci-stub',
    appId: '1:000000000000:ios:00000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ci-stub',
    iosBundleId: 'com.example.fateDeveloperCase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'ci-stub',
    appId: '1:000000000000:ios:00000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ci-stub',
    iosBundleId: 'com.example.fateDeveloperCase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'ci-stub',
    appId: '1:000000000000:web:00000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ci-stub',
  );
}

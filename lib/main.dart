import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fate_developer_case/app.dart';
import 'package:fate_developer_case/di/di.dart';
import 'package:fate_developer_case/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //pluginlerin çalışması için gerekli.

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  runApp(const FateDeveloperCaseApp());
}

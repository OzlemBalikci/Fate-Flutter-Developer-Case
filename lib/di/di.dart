import 'package:dio/dio.dart';
import 'package:fate_developer_case/core/network/api_config.dart';
import 'package:fate_developer_case/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class RegisterModule {
  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
      ),
    );
  }
}

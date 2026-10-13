// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:fate_developer_case/di/di.dart' as _i500;
import 'package:fate_developer_case/features/auth/data/repositories/firebase_auth_repository.dart'
    as _i58;
import 'package:fate_developer_case/features/auth/data/repositories/firestore_user_repository.dart'
    as _i508;
import 'package:fate_developer_case/features/auth/data/repositories/prefs_onboarding_repository.dart'
    as _i597;
import 'package:fate_developer_case/features/auth/domain/repositories/auth_repository.dart'
    as _i634;
import 'package:fate_developer_case/features/auth/domain/repositories/onboarding_repository.dart'
    as _i444;
import 'package:fate_developer_case/features/auth/domain/repositories/user_repository.dart'
    as _i259;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i259.UserRepository>(
      () => _i508.FirestoreUserRepository(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i444.OnboardingRepository>(
      () => _i597.PrefsOnboardingRepository(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i634.AuthRepository>(
      () => _i58.FirebaseAuthRepository(gh<_i59.FirebaseAuth>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i500.RegisterModule {}

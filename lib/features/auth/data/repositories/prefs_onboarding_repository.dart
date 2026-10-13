import 'package:fate_developer_case/features/auth/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: OnboardingRepository)
class PrefsOnboardingRepository implements OnboardingRepository {
  const PrefsOnboardingRepository(this._prefs);

  static const _key = 'onboarding_completed';

  final SharedPreferences _prefs;

  @override
  bool get isCompleted => _prefs.getBool(_key) ?? false;

  @override
  Future<void> complete() => _prefs.setBool(_key, true);
}

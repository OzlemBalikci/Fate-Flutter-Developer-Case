abstract interface class AuthRepository {
  String? get currentUid;
  Stream<String?> watchAuthState();
  Future<String> signInAnonymously();
}

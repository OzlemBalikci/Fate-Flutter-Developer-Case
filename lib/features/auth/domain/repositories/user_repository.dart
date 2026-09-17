abstract interface class UserRepository {
  Future<void> ensureUserDocument(String uid);
  Stream<bool> watchIsPro(String uid);
  Future<void> setPro(String uid);
}

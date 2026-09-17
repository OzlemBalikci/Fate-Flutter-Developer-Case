import 'package:firebase_auth/firebase_auth.dart';
import 'package:fate_developer_case/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:fate_developer_case/core/errors/exceptions.dart';

@LazySingleton(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  const FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Stream<String?> watchAuthState() =>
      _auth.authStateChanges().map((user) => user?.uid);

  @override
  Future<String> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      return credential.user!.uid;
    } on FirebaseAuthException catch (error, stackTrace) {
      throw UnauthorizedException(
        message: error.message,
        cause: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw NetworkException(cause: error, stackTrace: stackTrace);
    }
  }
}

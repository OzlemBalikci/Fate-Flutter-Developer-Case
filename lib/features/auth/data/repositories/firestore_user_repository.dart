import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fate_developer_case/features/auth/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class FirestoreUserRepository implements UserRepository {
  const FirestoreUserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _firestore.collection('users').doc(uid);

  @override
  Future<void> ensureUserDocument(String uid) async {
    final snapshot = await _doc(uid).get();
    if (!snapshot.exists) {
      await _doc(uid).set({'isPro': false});
    }
  }

  @override
  Stream<bool> watchIsPro(String uid) =>
      _doc(uid)
          .snapshots()
          .map((snap) => snap.data()?['isPro'] as bool? ?? false);

  @override
  Future<void> setPro(String uid) => _doc(uid).update({'isPro': true});
}

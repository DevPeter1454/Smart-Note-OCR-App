import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/services/authentication_service.dart';

class FirestoreService {
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final log = getLogger("FirestoreService");

  Future<void> createNewUser({
    required String email,
    required String displayName,
  }) async {
    log.d(currentUser!.uid);
    await _firebaseFirestore.collection('users').doc(currentUser!.uid).set({
      'email': email,
      'displayName': displayName,
    });
  }

  Future<void> updateDisplayName({required String displayName}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({'displayName': displayName});
  }

  Future<void> updateEmail({required String email}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({'email': email});
  }
}

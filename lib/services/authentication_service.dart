import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get currentStream => _firebaseAuth.authStateChanges();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> verifyEmail() async {
    await _firebaseAuth.currentUser!.sendEmailVerification();
  }

  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser!.reload();
  }

  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
  }

  Future<void> updateEmail({
    required String email,
  }) async {
    await _firebaseAuth.currentUser!.updateEmail(email);
  }

  Future<void> updatePassword({
    required String password,
  }) async {
    await _firebaseAuth.currentUser!.updatePassword(password);
  }

  Future<void> createNewUser({
    required String email,
    required String displayName,
  }) async {
    // log.d(currentUser!.uid);
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

  Future<void> updateEmailInDB({required String email}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({'email': email});
  }
  // Future<void>
}

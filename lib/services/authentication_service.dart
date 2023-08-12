import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get currentStream => _firebaseAuth.authStateChanges();

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

  
}

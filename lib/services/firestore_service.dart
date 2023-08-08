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

  Future<void> addNote(String title, String content) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .add({
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote(
      {required String title,
      required String content,
      required String noteId}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(noteId)
        .update({
      'title': title,
      'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(noteId)
        .delete();
  }

  Stream<QuerySnapshot> getNotes() {
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> getNoteDetail({required String noteId}) {
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(noteId)
        .snapshots();
  }
}

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

  Future<String> addNote(
      List<dynamic> content, String plainText, String category) async {
    final response = await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .add({
      'content': content,
      'plainText': plainText,
      'category': category,
      'createdAt': FieldValue.serverTimestamp(),
    });
    log.d(response.id);
    return response.id;
  }

  Future<void> updateNote(
      {required List<dynamic> content, required String noteId, required String plainText , required String category}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(noteId)
        .update({
      'plainText': plainText,
      'category': category,
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

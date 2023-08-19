import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/services/authentication_service.dart';

class FirestoreService {
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => _authenticationService.currentUser;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestoreInstance => _firebaseFirestore;

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

  Future<dynamic> getUserDetails() async {
    final DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    log.d(documentSnapshot.data());
    return documentSnapshot.data();
  }

  Future<void> updatePhotoURL({required String photoURL}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({'photoURL': photoURL});
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

  Future<void> updatePhotoUrl({required String url}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({'photoURL': url});
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
      {required List<dynamic> content,
      required String noteId,
      required String plainText,
      required String category}) async {
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

  Stream<QuerySnapshot> getChats() {
    log.d('Getting Chat');
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .orderBy('createTime', descending: false)
        .snapshots();
  }

  Future<void> sendPrompt({required String message}) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc()
        .set({
      'prompt': message,
    });
  }

  Stream<DocumentSnapshot> getNoteDetail({required String noteId}) {
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(noteId)
        .snapshots();
  }

  Future<dynamic> getExtractedImage({required String fileName}) async {
    final notesCollection =
        _firebaseFirestore.collection('users/extractedTexts/notes');
    QuerySnapshot notesSnapshot = await notesCollection.get();
    for (QueryDocumentSnapshot noteDocument in notesSnapshot.docs) {
      // Access the data of each note document
      Map<String, dynamic> noteData =
          noteDocument.data() as Map<String, dynamic>;

      // Compare the 'file' parameter with your desired value
      String fileValue = noteData['file'] as String;

      // Perform your comparison here
      if (fileValue == fileName) {
        // Do something when the comparison is true
        return noteDocument.data();
      }
    }
  }
}

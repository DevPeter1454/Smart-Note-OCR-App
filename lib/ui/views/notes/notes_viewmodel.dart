import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/models/note_model.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:smartnote/services/notes_service.dart';
import 'package:smartnote/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:share_plus/share_plus.dart';

class NotesViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
  final _notesService = locator<NotesService>();
  final _userService = locator<UserService>();
  final log = getLogger('NotesViewModel');
  void navigateToCreateNoteView() {
    _navigationService.navigateTo(Routes.addNoteView);
  }

  String get name => _userService.userData!.displayName.split(' ')[0];
  void init() async {
    setBusy(true);
    try {
      final response = await _firestoreService.getUserDetails();
      _userService.setUserModel(response);
      log.d(_userService.userData!.email);
    } catch (e) {
      _snackbarService.showSnackbar(message: e.toString());
    }
    setBusy(false);
  }

  List<NoteModel> notes = [];

  dynamic convertDocsToNote(List<dynamic> docs) {
    for (var doc in docs) {
      log.d(doc.id);
      notes.add(NoteModel(
        plainText: doc.data()['plainText'],
        content: doc.data()['content'],
        category: doc.data()['category'],
        id: doc.id,
      ));
    }

    return notes;
  }

  void navigateToEditNoteView(dynamic note) {
    log.d(note.data()['content']);

    _notesService.clearCurrentNote();
    _notesService.setCurrentNote(NoteModel(
        plainText: note.data()['plainText'],
        content: note.data()['content'],
        category: note.data()['category'],
        id: note.id));
    _navigationService.navigateTo(Routes.addNoteView);
  }

  dynamic getCategoryColor(String category) {
    switch (category) {
      case 'Work':
        return const Color(0xFF64B5F6).withOpacity(0.2);
      case 'Personal':
        return const Color(0xFF81C784).withOpacity(0.2);
      case 'Shopping':
        return const Color(0xFFFFD54F).withOpacity(0.2);
      case 'School':
        return const Color(0xFFFFAB91).withOpacity(0.2);
      case 'Ideas':
        return const Color(0xFFFFCC80).withOpacity(0.2);
      case 'Travel':
        return const Color(0xFFE57373).withOpacity(0.2);
      case 'Health':
        return const Color(0xFF4DB6AC).withOpacity(0.2);
      case 'Others':
        return const Color(0xFFAED581).withOpacity(0.2);
    }
  }

  void copyText(String text) {
    FlutterClipboard.copy(text).then((value) {
      _snackbarService.showSnackbar(
          message: "Text successfully copied to your clipboard",
          duration: const Duration(seconds: 2));
    });
    _navigationService.back();
  }

  void deleteNote(String noteId) async {
    _navigationService.back();

    _snackbarService.showSnackbar(
      message: 'Are you sure you want to delete this note?',
      title: 'Delete',
      duration: const Duration(seconds: 2),
      mainButtonTitle: 'Yes',
      onMainButtonTapped: () => deleteNoteFinally(noteId),
    );
  }

  void deleteNoteFinally(String noteId) async {
    setBusy(true);
    try {
      await _firestoreService.deleteNote(
        noteId: noteId,
      );
      _snackbarService.showSnackbar(
          message: 'Note deleted successfully',
          duration: const Duration(seconds: 2));
    } on FirebaseException catch (e) {
      _snackbarService.showSnackbar(message: e.message.toString());
    }
    setBusy(false);
  }

  void shareContent(BuildContext context, String text) {
    _navigationService.back();
    Share.share(text);
  }

  @override
  Stream<QuerySnapshot> get stream => _firestoreService.getNotes();
  @override
  void onData(data) {
    super.onData(data);
    // log.i(data.docs.first.id);
    _notesService.setNotesList(convertDocsToNote(data.docs));
    if (data == null) {
      _snackbarService.showSnackbar(message: 'No notes added yet');
    }
    notifyListeners();
  }

  @override
  void onError(error) {
    super.onError(error);
    _snackbarService.showSnackbar(message: error.toString());
  }

  @override
  void onSubscribed() {
    super.onSubscribed();
    log.i('onSubscribed');
  }
}

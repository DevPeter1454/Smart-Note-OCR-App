import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/models/note_model.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:smartnote/services/notes_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotesViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
  final _notesService = locator<NotesService>();
  final log = getLogger('NotesViewModel');
  void navigateToCreateNoteView() {
    _navigationService.navigateTo(Routes.addNoteView);
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

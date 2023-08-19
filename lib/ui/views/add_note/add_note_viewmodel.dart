import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/models/note_model.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:smartnote/services/notes_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddNoteViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
  final _noteService = locator<NotesService>();
  final log = getLogger('AddNoteViewModel');

  // void getCurrentNote

  String _title = 'Add Note';
  String get title => _title;

  int _tag = 1;
  int get tag => _tag;

  String _currentCategory = 'Work';
  String get currentCategory => _currentCategory;
  List<String> options = [
    'Work',
    'Personal',
    'Shopping',
    'School',
    'Ideas',
    'Travel',
    'Health',
    'Others'
  ];

  List<IconData> optionIcons = [
    Icons.work,
    Icons.person,
    Icons.shopping_cart,
    Icons.school,
    Icons.lightbulb,
    Icons.flight,
    Icons.favorite,
    Icons.more_horiz,
  ];

  List<Color> optionColors = [
    const Color(0xFF64B5F6),
    const Color(0xFF81C784),
    const Color(0xFFFFD54F),
    const Color(0xFFFFAB91),
    const Color(0xFFFFCC80),
    const Color(0xFFE57373),
    const Color(0xFF4DB6AC),
    const Color(0xFFAED581),
  ];

  void setSelectedCategory(int index) {
    _tag = index;
    _currentCategory = options[index];
    notifyListeners();
  }

  void pop() {
    _noteService.clearCurrentNote();
    _navigationService.back();
  }

  void navigateToNotesView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }

  Document document = Document.fromDelta(Delta()..insert('\n'));

  final QuillController _controller = QuillController.basic();

  QuillController get notesController => _controller;

  void init() {
    // log.i(_noteService.currentNote!.content);
    if (_noteService.currentNote == null) {
      log.d('new note');
      log.d(_noteService.fromImageToText);
      _controller.document = Document.fromDelta(Delta()..insert('\n'));
    
    } else {
      if(_noteService.fromImageToText == true){
        log.d('from image to text');
        _controller.document = Document.fromDelta(Delta()..insert(_noteService.currentNote!.content));
        notifyListeners();
        _title = 'Add Note';
        _tag = 0;
        _currentCategory = options[0];
        notifyListeners();

    }else{
      NoteModel? currentNote = _noteService.currentNote;
      // log.d(currentNote!.id);
      _controller.document = Document.fromJson(currentNote!.content);
      _currentCategory = currentNote.category;
      _tag = options.indexOf(currentNote.category);
      _title = 'Edit Note';
      notifyListeners();
    }
  }
  }

  Future<void> updateNote() async {
    setBusy(true);

    try {
      await _firestoreService.updateNote(
        content: _controller.document.toDelta().toJson(),
        noteId: _noteService.currentNote!.id!,
        plainText: _controller.document.toPlainText(),
        category: _currentCategory,
      );
      _snackbarService.showSnackbar(
          message: 'Note updated successfully',
          title: 'Success',
          duration: const Duration(seconds: 2));
      Future.delayed(const Duration(seconds: 2), () {
        // _controller.dispose();
        _noteService.clearCurrentNote();
        navigateToNotesView();
      });
    } on FirebaseException catch (e) {
      log.e(e);
      _snackbarService.showSnackbar(
        message: e.message!,
        title: 'Error',
      );
    }
    setBusy(false);
  }

  Future<void> saveNote() async {
    if (_noteService.currentNote == null ) {
      addNote();
    } else if(_noteService.currentNote != null && _noteService.fromImageToText == true){
      addNote();
        _noteService.setFromImageToText(false);
        _noteService.clearCurrentNote();  
    }
    
     else {
      updateNote();
    }
    _noteService.clearCurrentNote();
  }

  Future<void> addNote() async {
    setBusy(true);
    try {
      final response = await _firestoreService.addNote(
          _controller.document.toDelta().toJson(),
          _controller.document.toPlainText(),
          _currentCategory);
      if (response.isNotEmpty) {
        _snackbarService.showSnackbar(
            message: 'Note added successfully',
            title: 'Success',
            duration: const Duration(seconds: 2));
        Future.delayed(const Duration(seconds: 2), () {
          // _controller.dispose();

          navigateToNotesView();
        });
      }
    } on FirebaseException catch (e) {
      log.e(e);
      _snackbarService.showSnackbar(
        message: e.message!,
        title: 'Error',
      );
    }
    setBusy(false);
  }

  Future<bool> onWillPop() async {
    pop();
    return true;
  }
}

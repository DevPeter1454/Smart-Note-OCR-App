import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddNoteViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
  final log = getLogger('AddNoteViewModel');
  void pop() {
    _navigationService.back();
  }

  void navigateToNotesView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }

  Document document = Document.fromDelta(Delta()..insert('\n'));

  final QuillController _controller = QuillController.basic();

  QuillController get notesController => _controller;

  Future<void> addNote() async {
    setBusy(true);
    try {
      final response = await _firestoreService.addNote(
          _controller.document.toDelta().toJson(),
          _controller.document.toPlainText());
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

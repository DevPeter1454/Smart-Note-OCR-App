import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/models/note_model.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotesViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
  final log = getLogger('NotesViewModel');
  void navigateToCreateNoteView() {
    _navigationService.navigateTo(Routes.addNoteView);
  }

  List<NoteModel> notes = [];
  // dynamic get notes => data;

  // List<NoteModel> get notes => data.docs
  //     .forEach((doc) => NoteModel.fromMap(doc.data() as Map<String, dynamic>))
  //     .toList();

  dynamic convertDocsToNote(List<dynamic> docs) {
    for (var doc in docs) {
      notes.add(NoteModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return notes;
  }

  @override
  Stream<QuerySnapshot> get stream => _firestoreService.getNotes();
  @override
  void onData(data) {
    super.onData(data);
    // log.i(data.docs.first.data());
    // log.d(convertDocsToNote(data.docs));
    // Future.delayed(const Duration(seconds: 4), () {
    //   // notes = convertDocsToNote(data.docs);
    //   log.i(convertDocsToNote(data.docs));
    // });
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

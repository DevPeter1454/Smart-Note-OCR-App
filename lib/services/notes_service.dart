import 'package:smartnote/models/note_model.dart';

class NotesService {
  List<NoteModel> _notesList = [];
  List<NoteModel> get notesList => _notesList;

  bool _fromImageToText = false;

  bool get fromImageToText => _fromImageToText;

  void setFromImageToText(bool fromImageToText) {
    _fromImageToText = fromImageToText;
  }


  NoteModel? _currentNote;
  NoteModel? get currentNote => _currentNote;

  void setNotesList(List<NoteModel> notesList) {
    _notesList = notesList;
  }

  void setCurrentNote(NoteModel currentNote) {
    _currentNote = currentNote;
   
  }

  void clearCurrentNote() {
    _currentNote = null;
  }
}

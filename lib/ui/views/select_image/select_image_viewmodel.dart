import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/models/note_model.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:smartnote/services/notes_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectImageViewModel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final storageRef = FirebaseStorage.instance.ref();
  final _firestoreService = locator<FirestoreService>();
  final _notesService = locator<NotesService>();
  final _navigationService = locator<NavigationService>();

  final log = getLogger('SelectImageViewModel');
  File? _image;
  String? fileName;

  String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final codeUnits = List.generate(
      length,
      (index) => chars.codeUnitAt(random.nextInt(chars.length)),
    );
    return String.fromCharCodes(codeUnits);
  }

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
      log.i('Image picked');
      await uploadImage();
    } else {
      _snackbarService.showSnackbar(
        message: 'No image selected',
        duration: const Duration(seconds: 1),
      );
    }
    // log.i('Image: $_image');
  }

  Future<void> getImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
      log.i('Image picked');
      await uploadImage();
    } else {
      _snackbarService.showSnackbar(
        message: 'No image selected',
        duration: const Duration(seconds: 1),
      );
    }
    log.i('Image: $_image');
  }

  Future<void> uploadImage() async {
    setBusy(true);
    try {
      final generatedString = generateRandomString(10);
      final uploadTask =
          storageRef.child('users/images/$generatedString').putFile(
              _image!,
              SettableMetadata(customMetadata: {
                'uploaded_by': 'user',
                'uid': generateRandomString(10),
                'created_at': DateTime.now().toIso8601String(),
                'updated_at': DateTime.now().toIso8601String(),
              }));
      await uploadTask.whenComplete(() async {
        final downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
        fileName =
            'gs://${uploadTask.storage.bucket}/users/images/$generatedString';
        log.i('uid: $fileName');
        log.i('downloadUrl: $downloadUrl');
        // notifyListeners();

        //then get the text save as note model and set as current note then u can proceed to edit it
      });

      _snackbarService.showSnackbar(
          message: 'Image uploaded successfully, please wait for processing',
          duration: const Duration(seconds: 2),
          title: 'Upload Image');
      notifyListeners();
      setBusy(false);
      Future.delayed(const Duration(seconds: 2), () async {
        final result =
            await _firestoreService.getExtractedImage(fileName: fileName!);
        if(result == null){
          _snackbarService.showSnackbar(
              message: 'Image not processed yet, please try again later or try another image' ,
              duration: const Duration(seconds: 2),
              title: 'Upload Image');
          return;
        }
        if (result != null) {
          log.i('result: ${result['text']}');
          _notesService.setCurrentNote(NoteModel(
              plainText: result['text'],
              content: "${result['text']}\n"
              ,
              category: 'Work'));
            _notesService.setFromImageToText(true);
            _navigationService.navigateTo(Routes.addNoteView);
          // getExtractedTextFromImages(result);
          // _notesService.setCurrentNote(NoteModel(
          //     plainText: result,
          //     content: [
          //       {"insert": "$result\n"}
          //     ],
          //     category: 'Work'));
          // log.i('currentNote: ${_notesService.currentNote!.plainText}');
        }
        // _navigationService.navigateTo(Routes.editNoteView);
      });
    } on FirebaseException catch (e) {
      log.e(e);
      _snackbarService.showSnackbar(
          message: e.toString(),
          duration: const Duration(seconds: 2),
          title: 'Upload Image');
      setBusy(false);
    }
  }

  void getExtractedTextFromImages(dynamic response) {
    log.i('response: ${response.runtimeType}');
    for (var item in response) {
      log.i('item: ${item.runtimeType}');
    }
    // if(response!=null){
    //   _notesService.setCurrentNote(NoteModel(
    //       plainText: response,
    //       content: [
    //         {"insert": "$response\n"}
    //       ],
    //       category: 'Work'));
    //   log.i('currentNote: ${_notesService.currentNote!.plainText}');
    // }
  }
}

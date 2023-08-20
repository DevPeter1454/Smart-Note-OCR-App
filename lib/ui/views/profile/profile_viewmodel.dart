import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/services/authentication_service.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:smartnote/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:smartnote/ui/views/profile/profile_view.form.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends FormViewModel {
  final _userService = locator<UserService>();
  final _firestoreService = locator<FirestoreService>();
  final _authenticationService = locator<AuthenticationService>();
  final _snackBarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('ProfileViewModel');
  final storageRef = FirebaseStorage.instance.ref();
  late File image;
  String? imageName;

  String? _profileInitial;

  String? get profileInitial => _profileInitial;

  Future<void> pickImages() async {
    log.i('pickImages');
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        image = File(result.files.single.path!);
        imageName = trimString(result.files.single.name, 15);
        notifyListeners();
      }
      await uploadImage();
    } catch (e) {
      log.e(e);
    }
  }

  Future<void> uploadImage() async {
    setBusy(true);
    try {
      final uploadTask =
          storageRef.child('user/avatar/$imageName').putFile(image);
      await uploadTask.whenComplete(() async {
        final downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
        await _firestoreService.updatePhotoUrl(url: downloadUrl);
      });

      final response = await _firestoreService.getUserDetails();
      _userService.setUserModel(response);
      _photoUrl = _userService.userData!.photoURL;
      notifyListeners();
      _snackBarService.showSnackbar(
          message: 'Image uploaded successfully',
          duration: const Duration(seconds: 2),
          title: 'Upload Image');
    } catch (e) {
      log.e(e);
      _snackBarService.showSnackbar(
          message: e.toString(),
          duration: const Duration(seconds: 2),
          title: 'Upload Image Error');
    }
    setBusy(false);
  }

  String? _photoUrl;

  String? get photoUrl => _photoUrl;

  String? _name;
  String? _email;

  String? get name => _name;
  String? get email => _email;

  void init() {
    nameValue = _userService.userData!.displayName;
    emailValue = _userService.userData!.email;
    _name =_userService.userData!.displayName;
    _email = _userService.userData!.email;
    _photoUrl = _userService.userData!.photoURL;
    _profileInitial = _userService.userData!.displayName.split(' ').first;
    notifyListeners();
  }

  String trimString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  void logout() async {
    _snackBarService.showSnackbar(
        message: 'Are you sure you want to log out?',
        duration: const Duration(seconds: 2),
        title: 'Log out',
        mainButtonTitle: 'Yes',
        onMainButtonTapped: () async {

          await _authenticationService.signOut();
          _userService.clearUserModel();
          _navigationService.clearStackAndShow(Routes.startupView);
        });
    return;
  }

  @override
  void setFormStatus() {}
}

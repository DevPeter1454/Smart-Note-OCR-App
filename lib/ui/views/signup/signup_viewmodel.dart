import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/services/authentication_service.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:smartnote/ui/views/signup/signup_view.form.dart';

class SignupViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final log = getLogger('SignupViewModel');

  @override
  void setFormStatus() {}

  Future<void> createAccount() async {
    setBusy(true);
    if (hasAnyValidationMessage) {
      _snackBarService.showSnackbar(
          message: 'Please fix the errors on the form');
      setBusy(false);
      return;
    }
    try {
      await _authenticationService.createUserWithEmailAndPassword(
          email: emailValue!, password: passwordValue!);
      User? currentUser = _authenticationService.currentUser;
      if (currentUser != null) {
        await _firestoreService.createNewUser(
            email: emailValue!, displayName: displayNameValue!);
      }
      _snackBarService.showSnackbar(
          message: 'Account created successfully',
          duration: const Duration(seconds: 2),
          title: 'Create Account');
    } on FirebaseException catch (e) {
      log.e(e);
      _snackBarService.showSnackbar(
          message: e.message.toString(),
          duration: const Duration(seconds: 2),
          title: 'Create Account Error');
    }
    setBusy(false);
  }

  Future<void> navigateToLogin() async {
    await _navigationService.replaceWith(Routes.loginView,
        transition: (context, animation, secondaryAnimation, child) =>
            ScaleTransition(scale: animation, child: child));
  }
}

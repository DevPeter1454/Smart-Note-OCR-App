import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/app/app.router.dart';
import 'package:smartnote/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:smartnote/ui/views/login/login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('LoginViewModel');

  @override
  void setFormStatus() {}

  Future<void> login() async {
    setBusy(true);
    try {
      await _authenticationService.signInWithEmailAndPassword(
          email: emailValue!, password: passwordValue!);
    } on FirebaseAuthException catch (e) {
      log.e(e);
      _snackBarService.showSnackbar(
          message: e.message.toString(),
          duration: const Duration(seconds: 2),
          title: 'Login Error');
    }
    setBusy(false);
  }

  Future<void> forgotPassword() async {
    setBusy(true);
    try {
      await _authenticationService.sendPasswordResetEmail(email: emailValue!);
    } on FirebaseAuthException catch (e) {
      log.e(e);
      _snackBarService.showSnackbar(
          message: e.message.toString(),
          duration: const Duration(seconds: 2),
          title: 'Forgot Password Error');
    }
  }

  Future<void> navigateToCreateAccount() async {
    await _navigationService.navigateTo(Routes.signupView,
        transition: (context, animation, secondaryAnimation, child) =>
            ScaleTransition(scale: animation, child: child));
  }
}

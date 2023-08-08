import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class VerifyEmailViewModel extends StreamViewModel {
  final _authenticationService = locator<AuthenticationService>();

  User? get currentUser => data;

  @override
  Stream get stream => _authenticationService.currentStream;
}

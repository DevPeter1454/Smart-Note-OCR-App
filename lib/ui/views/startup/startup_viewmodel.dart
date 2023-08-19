import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:smartnote/app/app.locator.dart';

class StartupViewModel extends StreamViewModel {
  // final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final log = getLogger('StartupViewModel');
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream<User?> get currentStream => _authenticationService.currentStream;

  User? get currentUser => data;

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    // _navigationService.replaceWithHomeView();
    // _navigationService.replaceWith(Routes.loginView);
  }
  @override
  void onData(data){
    // log.i('onData');
    super.onData(data);
    log.d('onData: ${data?.email}');

  }

  @override
  Stream get stream => _authenticationService.currentStream;
}

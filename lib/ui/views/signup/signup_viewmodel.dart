import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();
  final _authenticationService = locator<AuthenticationService>();
  final log = getLogger('SignupViewModel');

  @override
  void setFormStatus() {}
}

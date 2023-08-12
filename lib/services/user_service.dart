import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/models/user_model.dart';
import 'package:smartnote/services/authentication_service.dart';

class UserService {
  final _authenticationService = locator<AuthenticationService>();
  UserModel? _model;

  UserModel? get userData => _model;

  void setUserModel(Map<String, dynamic> data) {
    _model = UserModel(
      email: data['email'],
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      uid: _authenticationService.currentUser!.uid,
    );
  }

  void clearUserModel() {
    _model = null;
  }
  
}

import 'package:stacked/stacked.dart';
import 'package:smartnote/ui/views/login/login_view.form.dart';


class LoginViewModel extends FormViewModel {


  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
    super.setFormStatus();
    setEmailValidationMessage( 'Email is required');
  }
}


class TextValidators{
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required';
    }
    if(!TextValidators().emailRegex.hasMatch(value)){
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }
    if(value.length < 6){
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
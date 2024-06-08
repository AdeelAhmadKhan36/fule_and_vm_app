import 'package:flutter/cupertino.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obsecureText = true;
  bool _isLoading = false;
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  //get values
  bool get obsecuretext => _obsecureText;
  bool get isLoading => _isLoading;
  bool get isPasswordObscure => _isPasswordObscure;
  bool get isConfirmPasswordObscure => _isConfirmPasswordObscure;
  // Add this getter

  set obsecuretext(bool newState) {
    _obsecureText = newState;
    notifyListeners();
  }

  set isLoading(bool newState) {
    _isLoading = newState;
    notifyListeners();
  }



  set isPasswordObscure(bool newState) {
    _isPasswordObscure = newState;
    notifyListeners();
  }

  set isConfirmPasswordObscure(bool newState) {
    _isConfirmPasswordObscure = newState;
    notifyListeners();
  }
}

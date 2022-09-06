import 'dart:async';

import 'package:flutter_architecture/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput , LoginViewModelOutput{

  final StreamController<String> _emailStreamController = StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController = StreamController<String>.broadcast();

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink<String> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));


  // private functions
  bool _isEmailValid(String email){
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  @override
  set setPassword(String password) {
    inputPassword.add(password);
  }
}

abstract class LoginViewModelInput {


  Sink<String> get inputEmail;
  Sink<String> get inputPassword;
  set setPassword(String password);
}

abstract class LoginViewModelOutput {

  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsPasswordValid;


}
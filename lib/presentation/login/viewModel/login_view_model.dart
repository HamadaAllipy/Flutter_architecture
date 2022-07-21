import 'dart:async';
import 'dart:developer';

import 'package:flutter_architecture/domain/useCase/login_use_case.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_architecture/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with _LoginViewModelInput, _LoginViewModelOutput {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  LoginObject _loginObject = LoginObject('', '');

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
  Sink<String> get inputEmailSink => _emailStreamController.sink;

  @override
  Sink<String> get inputPasswordSink => _passwordStreamController.sink;

  @override
  Stream<bool> get isEmailValidStream =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get isPasswordValidStream => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  void login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(_loginObject.email, _loginObject.password)))
        .fold((failure) => {
          log('Failure ${failure.statusMessage}')
    }, (authentication) => {
      log('authentication ${authentication.customerModel?.name}')
    });
  }

  @override
  void setPassword(String password) {
    inputPasswordSink.add(password);
    _loginObject = _loginObject.copyWith(password: password);
  }

  @override
  void setEmail(String email) {
    inputEmailSink.add(email);
    _loginObject = _loginObject.copyWith(email: email);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }
}

abstract class _LoginViewModelInput {
  void setEmail(String email);

  void setPassword(String password);

  void login();

  Sink<String> get inputEmailSink;

  Sink<String> get inputPasswordSink;
}

abstract class _LoginViewModelOutput {
  Stream<bool> get isEmailValidStream;

  Stream<bool> get isPasswordValidStream;
}

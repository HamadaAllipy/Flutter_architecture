import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/domain/useCase/login_use_case.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_architecture/presentation/common/data_class.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _enableLoginButtonStreamController =
      StreamController<void>.broadcast();
  LoginObject _loginObject = LoginObject(email: '', password: '');

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _passwordStreamController.close();
    _enableLoginButtonStreamController.close();
  }

  @override
  void login() async {

    inputFlowState.add(LoadingState(StateRendererType.dialogLoadingState, 'Loading'));
    (await _loginUseCase.execute(
            LoginUseCaseInput(_loginObject.email, _loginObject.password)))
        .fold(left, right);
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    _loginObject = _loginObject.copyWith(email: email);
    _enableLoginButtonStreamController.add(null);
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    _enableLoginButtonStreamController.add(null);
  }

  @override
  void start() {
    inputFlowState.add(ContentState());
    _enableLoginButtonStreamController.add(null);
  }

  @override
  Sink<String> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

  @override
  Stream<bool> get outputEmail =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputPassword => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  bool _isEmailValid(String email) => email.isNotEmpty;

  bool _isPasswordValid(String password) => password.isNotEmpty;

  @override
  Sink<void> get inputEnableLoginButton =>
      _enableLoginButtonStreamController.sink;

  @override
  Stream<bool> get outputEnableLoginButton =>
      _enableLoginButtonStreamController.stream.map((_) => _checkAllValid());

  bool _checkAllValid() {
    return _isEmailValid(_loginObject.email) &&
        _isPasswordValid(_loginObject.password);
  }

  right(AuthenticationModel right) {
    log('Success ${right.customerModel?.name}');
  }

  left(Failure failure) {
    inputFlowState.add(
        ErrorState(StateRendererType.dialogErrorState, failure.message, () {
      log('Executed');
    }));
    log('Failure ${failure.message}');
  }
}

abstract class LoginViewModelInput {
  void setEmail(String email);

  void setPassword(String password);

  void login();

  Sink<String> get inputEmail;

  Sink<String> get inputPassword;

  Sink<void> get inputEnableLoginButton;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputEmail;

  Stream<bool> get outputPassword;

  Stream<bool> get outputEnableLoginButton;
}

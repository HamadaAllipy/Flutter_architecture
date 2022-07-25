// Dart imports:
import 'dart:async';
import 'dart:developer';

import 'package:flutter_architecture/domain/useCase/login_use_case.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_architecture/presentation/common/freezed_data_classes.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with _LoginViewModelInput, _LoginViewModelOutput {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController<void> _allInputStreamController = StreamController<void>.broadcast();

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);
  // LoginViewModel();

  LoginObject _loginObject = LoginObject('', '');

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    inputFlowStateSink.add(ContentState());


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

    inputFlowStateSink.add(LoadingState(StateRendererType.dialogLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(_loginObject.email, _loginObject.password)))
        .fold((failure) {
      inputFlowStateSink.add(ErrorState(failure.statusMessage, StateRendererType.dialogErrorState));
      log('FAILURE => ');
    }, (authentication) {
      inputFlowStateSink.add(ContentState());
      log('SUCCESS => ');
    });
  }

  @override
  void setPassword(String password) {
    inputPasswordSink.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    inputAreFieldsValidSink.add(null);
  }


  @override
  void setEmail(String email) {
    inputEmailSink.add(email);
    _loginObject = _loginObject.copyWith(email: email);
    inputAreFieldsValidSink.add(null);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  Stream<bool> get areFieldsValid => _allInputStreamController.stream.map((event) => _checkAllFields());

  @override
  Sink<void> get inputAreFieldsValidSink => _allInputStreamController.sink;

  bool _checkAllFields(){
    return _isEmailValid(_loginObject.email) && _isPasswordValid(_loginObject.password);
  }

}

abstract class _LoginViewModelInput {
  void setEmail(String email);

  void setPassword(String password);

  void login();

  Sink<String> get inputEmailSink;

  Sink<String> get inputPasswordSink;

  Sink<void> get inputAreFieldsValidSink;
}

abstract class _LoginViewModelOutput {
  Stream<bool> get isEmailValidStream;

  Stream<bool> get isPasswordValidStream;

  Stream<bool> get areFieldsValid;
}

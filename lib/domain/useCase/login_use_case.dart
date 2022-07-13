import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/data/network/requests.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';
import 'package:flutter_architecture/domain/useCase/base_use_case.dart';

class LoginUseCase implements BaseUseCase<InputUseCase, AuthenticationModel> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationModel>> execute(
      InputUseCase input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class InputUseCase {
  final String email;
  final String password;

  InputUseCase(this.email, this.password);
}

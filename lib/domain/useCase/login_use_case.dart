import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/data/network/request.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';
import 'package:flutter_architecture/domain/useCase/base_use_case.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, AuthenticationModel> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationModel>> execute(
      LoginUseCaseInput input) async {
    return _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput(this.email, this.password);
}

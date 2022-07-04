import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/data/network/requests.dart';
import 'package:flutter_architecture/domain/models/models.dart';

abstract class Repository{

  Future<Either<Failure,AuthenticationModel>> login(LoginRequest loginRequest);
}
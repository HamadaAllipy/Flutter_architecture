// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:flutter_architecture/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}

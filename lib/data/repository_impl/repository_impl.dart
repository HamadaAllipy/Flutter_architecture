import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/app/app_constants.dart';
import 'package:flutter_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_architecture/data/mappers/mappers.dart';
import 'package:flutter_architecture/data/network/error_handler.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/data/network/network_info.dart';
import 'package:flutter_architecture/data/network/request.dart';
import 'package:flutter_architecture/data/response/response.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {

    if ( await _networkInfo.isConnected) {
      log('Connected');

      try {
        AuthenticationResponse response = await _remoteDataSource.login(loginRequest);
        if(response.status == 0){
          return Right(response.toDomain());
        }

        else{
          return Left(Failure(1, response.message ?? AppConstant.empty));
        }
      } on Exception catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      log('DisConnected');
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}

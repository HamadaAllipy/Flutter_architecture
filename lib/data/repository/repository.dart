// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:flutter_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_architecture/data/mapper/mapper.dart';
import 'package:flutter_architecture/data/network/error_handler.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/data/network/requests.dart';
import 'package:flutter_architecture/data/response/responses.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';

import '../network/network_info.dart';

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){
      // internet connected
     try {
       AuthenticationResponse response = await _remoteDataSource.login(loginRequest);
        if(response.statusCode == ApiInternalStatus.success){
          return Right(response.toDomain());
        }
        else{
          return Left(Failure(ApiInternalStatus.failure, response.message??ResponseMessage.unknown));
        }
     } on Exception catch (error) {
       return Left(ErrorHandler.handle(error).failure);
     }
    }
    else{
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

}

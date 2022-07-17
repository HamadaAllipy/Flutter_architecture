import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/data/data_sources/remote_data_source.dart';
import 'package:flutter_architecture/data/mapper/mapper.dart';
import 'package:flutter_architecture/data/network/error_handle.dart';
import 'package:flutter_architecture/data/network/failure.dart';
import 'package:flutter_architecture/data/network/network_info.dart';
import 'package:flutter_architecture/data/network/requests.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';

class RepositoryImpl implements Repository{

  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){
      // internet is connected
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if(response.status == ApiInternalStatus.success){
          // success login
          return Right(response.toDomain());
        }
        else{
          // Business error
          return Left(Failure(ApiInternalStatus.failure,response.message?? ResponseMessage.unknown));
        }
      } on Exception catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else{
      return Left(Failure(-1,'please check your internet'));
    }
  }
}
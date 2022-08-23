import 'package:flutter_architecture/data/network/app_api.dart';
import 'package:flutter_architecture/data/network/request.dart';
import 'package:flutter_architecture/data/response/response.dart';

abstract class RemoteDataSource {

  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {


  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) {
    return _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

}
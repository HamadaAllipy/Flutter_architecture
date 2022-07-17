import 'package:flutter_architecture/data/network/app_api.dart';
import 'package:flutter_architecture/data/network/requests.dart';
import 'package:flutter_architecture/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl(this._appServiceClient);

  final AppServiceClient _appServiceClient;

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  
}

import 'package:dio/dio.dart';
import 'package:flutter_architecture/app/app_constants.dart';
import 'package:flutter_architecture/data/response/response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';


@RestApi(baseUrl: AppConstant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) = _AppServiceClient;

  @POST('customers/login')
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}

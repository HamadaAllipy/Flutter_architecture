import 'package:dio/dio.dart';
import 'package:flutter_architecture/app/app_prefs.dart';
import 'package:flutter_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_architecture/data/network/app_api.dart';
import 'package:flutter_architecture/data/network/dio_factory.dart';
import 'package:flutter_architecture/data/network/network_info.dart';
import 'package:flutter_architecture/data/repository/repository.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';
import 'package:flutter_architecture/domain/useCase/login_use_case.dart';
import 'package:flutter_architecture/presentation/login/viewModel/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt instance = GetIt.instance;


Future<void> initAppModule()async{

  // init shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // app preferences
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance<AppPreferences>()));
  Dio dio = await instance<DioFactory>().getDio();

  // app service client
  instance.registerLazySingleton(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
}


void initLoginModule(){

  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance<Repository>()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance<LoginUseCase>()));
  }

}


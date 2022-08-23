import 'package:dio/dio.dart';
import 'package:flutter_architecture/app/app_prefs.dart';
import 'package:flutter_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_architecture/data/network/app_api.dart';
import 'package:flutter_architecture/data/network/dio_factory.dart';
import 'package:flutter_architecture/data/network/network_info.dart';
import 'package:flutter_architecture/data/repository_impl/repository_impl.dart';
import 'package:flutter_architecture/domain/repository/repository.dart';
import 'package:flutter_architecture/domain/useCase/login_use_case.dart';
import 'package:flutter_architecture/presentation/login/view/login_view.dart';
import 'package:flutter_architecture/presentation/login/viewModel/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  // shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // AppPreferences
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences));

  // dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(instance<AppPreferences>()));


  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(instance<DioFactory>().getDio()));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<NetworkInfo>(), instance<RemoteDataSource>()));
}


void initLoginModule(){

  // login use case
  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance<Repository>()));

  // login view model
  instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance<LoginUseCase>()));
}
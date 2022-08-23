import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/app/app_constants.dart';
import 'package:flutter_architecture/app/app_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String accept = 'Accept';
const String json = 'json';
const String contentType = 'Content-Type';
const String applicationJson = 'application/json';
const String token = AppConstant.token;
const String language = 'language';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Dio getDio() {
    Dio dio = Dio();
    String langFromPref = _appPreferences.getLang();
    Map<String, dynamic> headers = {
      accept: json,
      contentType: applicationJson,
      language: langFromPref,
    };
    dio.options = BaseOptions(
      headers: headers,
      receiveTimeout: AppConstant.receiveTimeout,
      sendTimeout: AppConstant.sendTimeout,
    );

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}

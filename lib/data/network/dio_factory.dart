// Flutter imports:
// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// Project imports:
import 'package:flutter_architecture/app/app_prefs.dart';
import 'package:flutter_architecture/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = 'application/json';
const String accept = 'Accept';
const String contentType = 'Content-Type';
const String language = 'language';
const String authorization = 'authorization';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String lang = await _appPreferences.getLanguage();

    Map<String, dynamic> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      language: lang,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      sendTimeout: Constants.timeOutApi,
      receiveTimeout: Constants.timeOutApi,
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_architecture/app/app_constants.dart';
import 'package:flutter_architecture/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  unAuthorised,
  forbidden,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cashError,
  noInternetConnection,
  unknown,
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unAuthorised = 401;
  static const int forbidden = 403;
  static const int internalServerError = 500;
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cashError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String success = 'success';
  static const String noContent = 'noContent';
  static const String badRequest = 'badRequest';
  static const String unAuthorised = 'unAuthorised';
  static const String forbidden = 'forbidden';
  static const String internalServerError = 'internalServerError';
  static const String connectTimeout = 'connectTimeout';
  static const String cancel = 'cancel';
  static const String receiveTimeout = 'receiveTimeout';
  static const String sendTimeout = 'sendTimeout';
  static const String cashError = 'cashError';
  static const String noInternetConnection = 'noInternetConnection';
  static const String unknown = 'unknown';
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cashError:
        return Failure(ResponseCode.cashError, ResponseMessage.cashError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ErrorHandler implements Exception {
  late final Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleDioError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        if (error.response != null) {
          return Failure(error.response?.statusCode ?? AppConstant.zero,
              error.response?.statusMessage ?? AppConstant.empty);
        }
        return DataSource.unknown.getFailure();
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.unknown.getFailure();
    }
  }
}

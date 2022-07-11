import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/network/failure.dart';


class ErrorHandler{

  late Failure failure;


  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      failure = _handleError(error);
    }
    else{
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch(error.type){
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        if(error.response?.statusMessage != null && error.response?.statusCode != null){
          return Failure(error.response?.statusCode??0, error.response?.statusMessage??'');
        }
        else{
          return DataSource.unknown.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.unknown.getFailure();
    }
  }
}


enum DataSource {
  success,
  notContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cashError,
  noInternetConnection,
  unknown,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.notContent:
        return Failure(ResponseCode.notContent, ResponseMessage.notContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorised:
        return Failure(ResponseCode.unauthorised, ResponseMessage.unauthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
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

class ResponseCode {
  static const int success = 200;
  static const int notContent = 201;
  static const int badRequest = 400;
  static const int unauthorised = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cashError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String success = 'Success';
  static const String notContent = 'Success';
  static const String badRequest = 'Bad request, try again later';
  static const String unauthorised = 'User is unauthorised, try again later';
  static const String forbidden = 'Forbidden request, try again later';
  static const String notFound = 'Error not found';
  static const String internalServerError =
      'Some thing went wrong ,try again later';

  // local status code
  static const String connectTimeout = 'Time out error, try again later';
  static const String cancel = 'Request was cancelled, try again later';
  static const String receiveTimeout = 'time out error, try again later';
  static const String sendTimeout = 'time out error, try again later';
  static const String cashError = 'cash error, try again later';
  static const String noInternetConnection =
      'Please check your internet connection';
  static const String unknown = 'some thing went wronk , try again later';
}


class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;

}
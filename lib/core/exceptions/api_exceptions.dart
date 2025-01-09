import 'package:memmatch/core/exceptions/app_exception.dart';
import 'package:memmatch/core/network/models/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../types/app_response_type.dart';

class ApiException implements Exception {
  String? message = "";
  int? statusCode = 0;

  dynamic extra;

  ApiException(this.message, {this.statusCode, this.extra});

  ApiException.dioException({required DioException error}) {
    _handleDioException(error);
  }

  ApiException.otherException({required Object otherException}) {
    _handleOtherException(otherException);
  }

  AppException appException() {
    return _mapApiExceptionToAppException();
  }

  AppException _mapApiExceptionToAppException() {
    AppResponseType responseType;

    switch (statusCode) {
      case 400:
        responseType = AppResponseType.badRequest;
        break;
      case 401:
        responseType = AppResponseType.unauthorized;
        break;
      case 403:
        responseType = AppResponseType.forbidden;
        break;
      case 404:
        responseType = AppResponseType.notFound;
        break;
      case 408:
        responseType = AppResponseType.connectionTimeout;
        break;
      case 500:
        responseType = AppResponseType.serverError;
        break;
      case 503:
        responseType = AppResponseType.serviceUnavailable;
        break;
      default:
        responseType = AppResponseType.somethingWentWrong;
    }

    return AppException(
      responseType,
      message,
      extra: extra,
    );
  }

  //error will be network related
  _handleDioException(DioException error) {
    String errorMessage = "";
    ApiException serverError;
    switch (error.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request Canceled";
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection time out";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Received timeout";
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 503) {
          errorMessage = "Something went wrong";
        } else if (error.response?.statusCode != 401) {
          errorMessage = handleBadRequest(error.response?.data);
        } else {
          errorMessage = "UnAuthorized";
        }
        break;
      case DioExceptionType.unknown:
        errorMessage = "Something went wrong";
        break;
      case DioExceptionType.sendTimeout:
        if (kReleaseMode) {
          errorMessage = "Something went wrong";
        } else {
          errorMessage = "Received timeout";
        }
        break;
      case DioExceptionType.connectionError:
        errorMessage = "No Internet connection";
        break;
      default:
        errorMessage = error.response?.statusMessage ?? "Something went wrong";
        break;
    }

    var extra;
    try {
      var errorHolder = error.response?.data;
      if (errorHolder is Map<String, dynamic>) {
        if (errorHolder.containsKey("status") &&
            errorHolder.containsKey("data") &&
            errorHolder.containsKey("message")) {
          extra = ApiResponse(
              status: errorHolder["status"],
              message: errorHolder["message"],
              data: errorHolder["data"]);
          errorMessage = errorHolder["message"];
        }
      }
    } catch (e) {
      //no impl
    }
    serverError = ApiException(errorMessage,
        statusCode: error.response?.statusCode ?? 0, extra: extra);
    print("HERE~~~ $errorMessage");
    message = errorMessage;
    statusCode = error.response?.statusCode ?? 0;
    return serverError;
  }

  String handleBadRequest(Map<String, dynamic>? errorData) {
    String error = "";
    error = "Something went wrong";
    return error;
  }

  _handleOtherException(Object otherException) {
    var errorMessage = "Something went Wrong";
    var serverError = ApiException(errorMessage, extra: otherException);
    return serverError;
  }
}

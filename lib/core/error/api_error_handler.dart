import 'package:dio/dio.dart';

import 'failures.dart';

class ApiErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const NetworkFailure('Connection timed out');
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return const ServerFailure('Request was cancelled');
        case DioExceptionType.connectionError:
          return const NetworkFailure();
        default:
          return const ServerFailure('Something went wrong');
      }
    }
    String message = error.toString();
    if (error is Exception) {
      message = error.toString().replaceFirst('Exception: ', '');
    }
    return ServerFailure(message);
  }

  static Failure _handleBadResponse(Response? response) {
    if (response == null) return const ServerFailure();

    final statusCode = response.statusCode;
    final data = response.data;
    final message = (data is Map && data.containsKey('message'))
        ? data['message'].toString()
        : 'Server returned error ($statusCode)';

    switch (statusCode) {
      case 400:
        return ServerFailure(message);
      case 401:
      case 403:
        return AuthFailure(message);
      case 404:
        return ServerFailure('Resource not found');
      case 500:
        return const ServerFailure('Internal server error');
      default:
        return ServerFailure(message);
    }
  }
}

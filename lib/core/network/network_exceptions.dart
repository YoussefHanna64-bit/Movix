import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return 'Request to API server was cancelled';
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout with API server';
        case DioExceptionType.receiveTimeout:
          return 'Receive timeout in connection with API server';
        case DioExceptionType.badResponse:
          return 'Received invalid status code: ${error.response?.statusCode}';
        case DioExceptionType.sendTimeout:
          return 'Send timeout in connection with API server';
        case DioExceptionType.connectionError:
          return 'No Internet connection';
        case DioExceptionType.badCertificate:
          return 'Bad Certificate';
        case DioExceptionType.unknown:
          return 'Unexpected error occurred';
      }
    } else {
      return 'Unexpected error occurred';
    }
  }
}

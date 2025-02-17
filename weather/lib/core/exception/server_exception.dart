import 'package:dio/dio.dart';

import 'server_error_message.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  factory ServerException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException(
            message: ServerErrorMessage.connectionTimeout.message,
            statusCode: 408);
      case DioExceptionType.sendTimeout:
        return ServerException(
            message: ServerErrorMessage.sendTimeout.message, statusCode: 408);
      case DioExceptionType.receiveTimeout:
        return ServerException(
            message: ServerErrorMessage.receiveTimeout.message,
            statusCode: 408);
      case DioExceptionType.badResponse:
        return ServerException(
          message:
              "${ServerErrorMessage.badResponse.message}: ${error.response?.statusCode} ${error.response?.statusMessage}",
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ServerException(
            message: ServerErrorMessage.requestCancelled.message);
      case DioExceptionType.connectionError:
        return ServerException(message: ServerErrorMessage.noInternet.message);
      default:
        return ServerException(message: ServerErrorMessage.unexpected.message);
    }
  }

  @override
  String toString() => "ServerException: $message (Status Code: $statusCode)";
}

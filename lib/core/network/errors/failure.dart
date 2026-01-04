import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again!!!!!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == null) {
      return ServerFailure(_extractErrorMessage(response));
    }

    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      return ServerFailure(_extractErrorMessage(response));
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 429) {
      return ServerFailure(
          'Too many requests. Please wait a moment and try again.');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else if (statusCode == 302) {
      return ServerFailure('Redirected: check API endpoint or headers');
    } else {
      log(statusCode.toString());
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  static String _extractErrorMessage(dynamic response) {
    if (response == null) {
      return 'Unexpected Error, Please try again!';
    }

    if (response is Map<String, dynamic>) {
      return response['error']?['message'] ??
          response['message'] ??
          response['error'] ??
          'Unexpected Error, Please try again!';
    }

    if (response is String) {
      return response;
    }

    return 'Unexpected Error, Please try again!';
  }
}

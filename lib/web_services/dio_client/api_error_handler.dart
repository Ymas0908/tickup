

import 'package:dio/dio.dart';
import 'package:tickup/exception/app_exception.dart';
import 'package:tickup/exception/response_error.dart';

class ApiErrorHandler implements Exception {
  static AppException handle(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return NetworkException();
    }
    print("Error:::: : ${error.response}");
    print("Error:::: : ${error.message}");
    print("Error:::: : ${error.response?.statusCode}");
    if (error.response != null) {
      ResponseError errorResponse = ResponseError.fromJson(
        error.response?.data,
      );
      print("Error:::: : ${errorResponse.message}");
      switch (error.response?.statusCode) {
        case 400:
          return BadRequestException(
            errorResponse.message ?? "Requête invalide",
          );
        case 401:
          return UnauthorizedException(
            errorResponse.message ?? "Authentification requise",
          );
        case 404:
          return NotFoundException(
            errorResponse.message ?? "Cette ressource n'existe pas",
          );
        case 409:
          return ConflictException(
            errorResponse.message ?? "Cette ressource existe déjà",
          );
        case 500:
          return ServerErrorException(
            errorResponse.message ?? "Erreur serveur",
          );
        default:
          return AppException(
            "Erreur inconnue (${error.response?.statusCode})",
          );
      }
    }
    return AppException(error.message ?? "Erreur inattendue");
  }
}

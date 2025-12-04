class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class BadRequestException extends AppException {
  BadRequestException(super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = "Session expirée"]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = "Ressource non trouvée"]);
}

class ConflictException extends AppException {
  ConflictException(super.message);
}

class ServerErrorException extends AppException {
  ServerErrorException([super.message = "Erreur serveur"]);
}

class NetworkException extends AppException {
  NetworkException([
    super.message = "Veuillez vérifier votre connexion internet",
  ]);
}

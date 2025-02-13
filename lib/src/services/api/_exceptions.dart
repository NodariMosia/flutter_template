part of 'api.dart';

/// statusCode == 400
class BadRequestException implements Exception {
  static int get code => HttpStatus.badRequest;

  final String message;

  const BadRequestException([this.message = 'BAD_REQUEST']);

  @override
  String toString() => message;
}

/// statusCode == 401
class UnauthorizedAccessException implements Exception {
  static int get code => HttpStatus.unauthorized;

  final String message;

  const UnauthorizedAccessException([this.message = 'UNAUTHORIZED_ACCESS']);

  @override
  String toString() => message;
}

/// statusCode == 404
class NotFoundException implements Exception {
  static int get code => HttpStatus.notFound;

  final String message;
  final String url;

  const NotFoundException(this.url, [this.message = 'NOT_FOUND']);

  @override
  String toString() => '$message: \'$url\'';
}

/// statusCode == 409
class ConflictException implements Exception {
  static int get code => HttpStatus.conflict;

  final String message;

  const ConflictException([this.message = 'CONFLICT']);

  @override
  String toString() => message;
}

/// statusCode == 444
class FailedHostLookupException extends SocketException {
  static int get code => HttpStatus.connectionClosedWithoutResponse;

  const FailedHostLookupException(
    String url, [
    String message = 'FAILED_HOST_LOOKUP',
  ]) : super('$message: \'$url\'');
}

/// statusCode == 500
class InternalServerError implements Exception {
  static int get code => HttpStatus.internalServerError;

  final String message;

  const InternalServerError([this.message = 'INTERNAL_SERVER_ERROR']);

  @override
  String toString() => message;
}

/// statusCode == 502
class BadGetawayException implements Exception {
  static int get code => HttpStatus.badGateway;

  final String message;

  const BadGetawayException([this.message = 'BAD_GETAWAY']);

  @override
  String toString() => message;
}

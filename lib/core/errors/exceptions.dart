sealed class AppException implements Exception {
  const AppException({
    this.message,
    this.statusCode,
    this.cause,
    this.stackTrace,
  });

  final String? message;
  final int? statusCode;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      '$runtimeType(statusCode: $statusCode, message: ${message ?? '-'})';
}

final class ServerException extends AppException {
  const ServerException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class NetworkException extends AppException {
  const NetworkException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class TimeoutException extends AppException {
  const TimeoutException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class NotFoundException extends AppException {
  const NotFoundException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class ValidationException extends AppException {
  const ValidationException({
    super.message,
    super.statusCode,
    this.errors = const {},
    super.cause,
    super.stackTrace,
  });

  final Map<String, List<String>> errors;
}

final class CacheException extends AppException {
  const CacheException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class DatabaseException extends AppException {
  const DatabaseException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class ParsingException extends AppException {
  const ParsingException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

final class UnknownException extends AppException {
  const UnknownException({
    super.message,
    super.statusCode,
    super.cause,
    super.stackTrace,
  });
}

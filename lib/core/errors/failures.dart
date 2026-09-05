import 'package:equatable/equatable.dart';
import 'package:fate_developer_case/core/errors/exceptions.dart';

sealed class Failure extends Equatable {
  const Failure({this.message, this.code});

  final String? message;
  final int? code;

  @override
  List<Object?> get props => [message, code];

  factory Failure.fromException(AppException exception) {
    return switch (exception) {
      ServerException() => ServerFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      NetworkException() => NetworkFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      TimeoutException() => TimeoutFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      UnauthorizedException() => AuthFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      ForbiddenException() => AuthFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      NotFoundException() => NotFoundFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      ValidationException(:final errors) => ValidationFailure(
        message: exception.message,
        code: exception.statusCode,
        errors: errors,
      ),
      CacheException() => CacheFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      DatabaseException() => DatabaseFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      ParsingException() => ParsingFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
      UnknownException() => UnexpectedFailure(
        message: exception.message,
        code: exception.statusCode,
      ),
    };
  }
}

final class ServerFailure extends Failure {
  const ServerFailure({super.message, super.code});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.code});
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message, super.code});
}

final class AuthFailure extends Failure {
  const AuthFailure({super.message, super.code});
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message, super.code});
}

final class ValidationFailure extends Failure {
  const ValidationFailure({super.message, super.code, this.errors = const {}});

  final Map<String, List<String>> errors;

  @override
  List<Object?> get props => [...super.props, errors];
}

final class CacheFailure extends Failure {
  const CacheFailure({super.message, super.code});
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message, super.code});
}

final class ParsingFailure extends Failure {
  const ParsingFailure({super.message, super.code});
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message, super.code});
}

// lib/core/failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(String message) : super(message);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure(String message) : super(message);
}

class CommonFailure extends Failure {
  const CommonFailure(String message) : super(message);
}

// You can add more specific failures as per your application's needs.

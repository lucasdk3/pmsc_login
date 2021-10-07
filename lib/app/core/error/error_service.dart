abstract class Failure implements Exception {}

class ErrorResponse extends Failure {
  final String? error;

  ErrorResponse({this.error});
}

class EmptyResponse extends Failure {}

class ErrorValidation extends Failure {}

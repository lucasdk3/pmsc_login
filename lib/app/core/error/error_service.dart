abstract class Failure implements Exception {}

class ErrorResponse extends Failure {}

class EmptyResponse extends Failure {}

class ErrorValidation extends Failure {}

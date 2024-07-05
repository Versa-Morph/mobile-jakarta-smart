class BaseException implements Exception {
  final String errorMsg;
  BaseException(this.errorMsg);
  @override
  String toString() => errorMsg;
}

class AuthException extends BaseException {
  AuthException(super.errorMsg);
}

class ReqTimeoutException extends BaseException {
  ReqTimeoutException(super.errorMsg);
}

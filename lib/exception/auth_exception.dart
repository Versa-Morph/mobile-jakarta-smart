class AuthException implements Exception {
  final String errorMsg;
  const AuthException(this.errorMsg);
  @override
  String toString() => errorMsg;
}

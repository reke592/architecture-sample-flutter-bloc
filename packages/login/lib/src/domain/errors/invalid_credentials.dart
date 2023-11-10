class InvalidCredentials implements Exception {
  final String message;
  InvalidCredentials([this.message = 'Invalid username or password']);
  @override
  String toString() => message;
}

class MaximumLoginAttempt implements Exception {
  final String message;
  MaximumLoginAttempt(
      [this.message =
          'You have reached the maximum login attempt. please try again later.']);
  @override
  String toString() => message;
}

enum LoginStatus {
  unknown,
  success,
  expired,
}

LoginStatus loginStatusFromString(String? value) {
  switch (value?.toLowerCase()) {
    case 'success':
      return LoginStatus.success;
    case 'expired':
      return LoginStatus.expired;
    default:
      return LoginStatus.unknown;
  }
}

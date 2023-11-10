import 'dart:async';

import 'package:login/login.dart';
import 'package:login/src/domain/errors/invalid_credentials.dart';
import 'package:login/src/domain/errors/maximum_login_attempt.dart';
import 'package:login/src/domain/login_repository.dart';

class LoginRepositoryMemory extends LoginRepository {
  final Map<String, Timer> _lock = {};
  final Map<String, int> _attempts = {};
  final List<Map<String, String>> _users = [
    {
      "username": "juanD",
      "password": "passkey",
    },
    {
      "username": "admin",
      "password": "admin",
    }
  ];

  @override
  Future<void> basicLogin({
    required String username,
    required String password,
  }) async {
    if (_attempts[username] == 5) {
      _lock.putIfAbsent(
        username,
        () => Timer(
          const Duration(seconds: 60),
          () {
            _lock.remove(username);
          },
        ),
      );
      throw MaximumLoginAttempt();
    }
    for (var record in _users) {
      if (record['username'] == username && record['password'] == password) {
        _attempts.remove(username);
        return;
      }
    }
    _attempts[username] = (_attempts[username] ?? 0) + 1;
    throw InvalidCredentials();
  }

  @override
  Future<void> logout() async {
    statusEvent.add(LoginStatus.expired);
  }
}

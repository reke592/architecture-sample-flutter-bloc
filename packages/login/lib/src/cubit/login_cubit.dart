import 'dart:async';

import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/foundation.dart';
import 'package:login/src/domain/enums/login_status.dart';
import 'package:login/src/domain/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends HydratedCubit<LoginState> {
  final LoginRepository _loginRepo;

  LoginCubit({required LoginRepository loginRepo})
      : _loginRepo = loginRepo,
        super(const LoginState());

  Future<void> basicLogin({
    required String username,
    required String password,
  }) async {
    try {
      emit(state.loading());
      await _loginRepo.basicLogin(
        username: username,
        password: password,
      );
      _loginRepo.statusEvent.add(LoginStatus.success);
      emit(state.success(LoginStatus.success));
    } catch (error) {
      emit(state.failed(error));
    }
  }

  Future<void> logout() async {
    emit(state.success(LoginStatus.expired));
    await _loginRepo.logout();
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) => LoginState(
        data: loginStatusFromString(json['status']),
      );

  @override
  Map<String, dynamic>? toJson(LoginState state) => {
        'status': state.data.name,
      };
}

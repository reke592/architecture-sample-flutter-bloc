import 'dart:async';

import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';

/// redirect to target location when LoginCubit data is not [LoginStatus.success]
FutureOr<String?> Function(BuildContext, GoRouterState) authGuard({
  target = '/login',
}) {
  return (BuildContext context, GoRouterState state) async {
    if (context.read<LoginCubit>().state.data != LoginStatus.success) {
      return target;
    }
    return null;
  };
}

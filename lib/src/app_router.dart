import 'package:ddd/src/dashboard/dashboard_page.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:todos/todos.dart';

class AppRouter {
  final String initialLocation;
  final rootNavigator = GlobalKey<NavigatorState>();

  AppRouter(this.initialLocation);

  late final config = GoRouter(
    initialLocation: initialLocation,
    navigatorKey: rootNavigator,
    observers: [
      PreviousRouteObserver(),
    ],
    routes: [
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        redirect: authGuard(),
        pageBuilder: (context, state) => const NoTransitionPage(
          child: DashboardPage(),
        ),
      ),
      configureLoginRoutes(rootNavigator),
      configureTodosRoutes(rootNavigator),
    ],
  );
}

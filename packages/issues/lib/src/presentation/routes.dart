import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/presentation/issue_list/bloc/issue_list_bloc.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/presentation/issue_list/issue_list_screen.dart';
import 'package:issues/src/presentation/issue_overview/issue_overview_screen.dart';

ShellRoute configureIssuesRoutes(
  GlobalKey<NavigatorState> rootNavigator, {
  String root = '/issues',
}) {
  final shellKey = GlobalKey<NavigatorState>();
  return ShellRoute(
    parentNavigatorKey: rootNavigator,
    navigatorKey: shellKey,
    observers: [PreviousRouteObserver()],
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
        child: BlocProvider(
          create: (context) => IssueListBloc(
            repo: context.read<IssuesRepository>(),
          )..add(LoadIssues()),
          child: child,
        ),
      );
    },
    routes: [
      GoRoute(
        name: 'Issue List',
        path: root,
        builder: (context, state) => const IssueListScreen(),
      ),
      GoRoute(
        name: 'new Issue',
        path: '$root/new',
        builder: (context, state) => const IssueOverviewScreen(),
      ),
      GoRoute(
        name: 'view Issue',
        path: '$root/:id/view',
        builder: (context, state) => IssueOverviewScreen(
          id: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
    ],
  );
}

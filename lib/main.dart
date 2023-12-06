import 'package:ddd/src/app_router.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:issues/issues.dart';
import 'package:login/login.dart';
import 'package:todos/todos.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(MyApp(
    router: AppRouter('/login'),
    scrollBehavior: AppScrollBehavior(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  final ScrollBehavior? scrollBehavior;
  const MyApp({
    super.key,
    required this.router,
    this.scrollBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepositoryMemory(),
        ),
        RepositoryProvider<TodosRepository>(
          create: (context) => TodosMemoryRepository(),
        ),
        RepositoryProvider<IssueRepository>(
          create: (context) => IssueMemoryRepository(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            loginRepo: context.read<LoginRepository>(),
          ),
        ),
        BlocProvider(create: (context) => ThemeCubit(activeIndex: 1)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: state.current.theme,
            routerConfig: router.config,
            scrollBehavior: scrollBehavior,
          );
        },
      ),
    );
  }
}

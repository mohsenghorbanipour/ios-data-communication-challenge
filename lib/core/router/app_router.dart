import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:zanis/core/router/routes.dart';
import 'package:zanis/modules/main/page/main_page.dart';

class AppRouter {
  late GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.main,
    routes: [
      _routeFade(
        name: Routes.main,
        path: Routes.main,
        pageBuilder: (state) => const MainPage()
      ),
    ],
  );

  GoRoute _routeFade({
    required String path,
    required String name,
    required Widget Function(GoRouterState state) pageBuilder,
    List<GoRoute> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: name,
        routes: routes,
        pageBuilder: (context, state) => (Platform.isIOS)
            ? CupertinoPage(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: pageBuilder(state),
              )
            : CustomTransitionPage(
                key: state.pageKey,
                child: pageBuilder(state),
                restorationId: state.pageKey.value,
                transitionsBuilder:
                    (context, animation, secondryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
      );
}

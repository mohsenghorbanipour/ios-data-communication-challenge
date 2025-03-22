import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:zanis/core/router/app_router.dart';
import 'package:zanis/core/theme/provider/theme_bloc.dart';
import 'package:zanis/core/theme/style/app_theme.dart' as myTheme;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (context) => AppRouter(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeBloc()..loadCurrentTheme(),
          ),
        ],
        child: Builder(
          builder: (context) => ThemeProvider(
            defaultThemeId: context.select<ThemeBloc, String>(
                (bloc) => bloc.currentThemeNoSystem.toString()),
            themes: [
              AppTheme(
                id: myTheme.theme.light.toString(),
                data: myTheme.AppTheme.light,
                description: 'light theme',
              ),
              AppTheme(
                id: myTheme.theme.dark.toString(),
                data: myTheme.AppTheme.dark,
                description: 'dark theme',
              ),
            ],
            child: ThemeConsumer(
              child: Builder(
                builder: (context) {
                  GoRouter router =
                      Provider.of<AppRouter>(context, listen: false).router;
                  return MaterialApp.router(
                    // We Dont Need This Property (Why) : The App is English not Persian
                    // localizationsDelegates: context.localizationsDelegates,
                    routeInformationParser: router.routeInformationParser,
                    routerDelegate: router.routerDelegate,
                    routeInformationProvider: router.routeInformationProvider,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeProvider.themeOf(context).data,
                  );
                },
              ),
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zanis/core/theme/provider/theme_bloc.dart';
import 'package:zanis/core/theme/style/app_theme.dart';
import 'package:zanis/modules/main/provider/main_page_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MainPageBloc(),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                if (Provider.of<ThemeBloc>(context, listen: false)
                    .isThemeSelected(theme.system)) {
                  Provider.of<ThemeBloc>(context, listen: false).setNewTheme(
                    context,
                    theme.light.toString(),
                  );
                } else if (Provider.of<ThemeBloc>(context, listen: false)
                    .isThemeSelected(theme.light)) {
                  Provider.of<ThemeBloc>(context, listen: false).setNewTheme(
                    context,
                    theme.dark.toString(),
                  );
                } else if (Provider.of<ThemeBloc>(context, listen: false)
                    .isThemeSelected(theme.dark)) {
                  Provider.of<ThemeBloc>(context, listen: false).setNewTheme(
                    context,
                    theme.system.toString(),
                  );
                }
              },
              icon: Icon(
                context.select<ThemeBloc, bool>(
                        (bloc) => bloc.isThemeSelected(theme.system))
                    ? Icons.brightness_auto
                    : context.select<ThemeBloc, bool>(
                            (bloc) => bloc.isThemeSelected(theme.light))
                        ? Icons.light_mode_sharp
                        : Icons.nightlight_round,
                size: 32,
              ),
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.select<MainPageBloc, String>((bloc) =>
                      bloc.tcpDate ?? 'Tap The Button To Recive Data ...'),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<MainPageBloc>(context, listen: false)
                        .loadDateFromTcpConnection();
                  },
                  child: const Text(
                    'Recive Data',
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

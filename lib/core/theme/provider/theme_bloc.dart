// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:zanis/core/resources/cache/config_box.dart';
import 'package:zanis/core/theme/data/theme_cache.dart';
import 'package:zanis/core/theme/style/app_theme.dart';
import 'package:theme_provider/theme_provider.dart' as themeProvider;

class ThemeBloc extends ChangeNotifier {
  factory ThemeBloc() => _instance;
  static final ThemeBloc _instance = ThemeBloc._init();
  ThemeBloc._init();

  String _currentThemeId = theme.system.toString();

  theme get currentTheme {
    if (_currentThemeId == theme.light.toString()) {
      return theme.light;
    } else if (_currentThemeId == theme.dark.toString()) {
      return theme.dark;
    } else {
      return theme.system;
    }
  }

  theme get currentThemeNoSystem {
    String themeIdNoSystem = _currentThemeId == theme.system.toString()
        ? AppTheme.getThemeIdBySystem()
        : _currentThemeId;
    if (themeIdNoSystem == theme.light.toString()) {
      return theme.light;
    } else {
      return theme.dark;
    }
  }

  set currentTheme(theme value) {
    _currentThemeId = value.toString();
    notifyListeners();
  }

  bool isThemeSelected(theme value) => currentTheme == value;

  Future<String> loadCurrentTheme() async {
    _currentThemeId = await ThemeCache.getThemeId();
    notifyListeners();
    return _currentThemeId;
  }

  Future<void> loadAndApplyTheme(BuildContext context) async {
    _currentThemeId = await ThemeCache.getThemeId();
    themeProvider.ThemeProvider.controllerOf(context)
        .setTheme(currentThemeNoSystem.toString());
    notifyListeners();
  }

  void setNewTheme(BuildContext context, String newThemeId) {
    _currentThemeId = newThemeId;
    notifyListeners();
    ThemeCache.setThemeId(newThemeId);
    themeProvider.ThemeProvider.controllerOf(context).setTheme(
        newThemeId == theme.system.toString()
            ? AppTheme.getThemeIdBySystem()
            : newThemeId);
  }

  Future<void> onSystemBrightnessChanged(
      BuildContext context, Brightness brightness) async {
    await loadCurrentTheme();
    if (currentTheme == theme.system) {
      if (brightness == Brightness.light) {
        themeProvider.ThemeProvider.controllerOf(context)
            .setTheme(theme.light.toString());
      } else if (brightness == Brightness.dark) {
        themeProvider.ThemeProvider.controllerOf(context)
            .setTheme(theme.dark.toString());
      }
    }
  }
}

import 'package:zanis/core/resources/cache/config_box.dart';
import 'package:zanis/core/theme/style/app_theme.dart';

class ThemeCache {
  static const String _themeIdKey = 'themeId';

  static Future<void> setThemeId(String? id) async {
    try {
      await ConfigBox.setConfig(_themeIdKey, id);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> getThemeId() async {
    String? baseUrl = await ConfigBox.getConfig(_themeIdKey);
    return baseUrl ?? theme.system.toString();
  }
}

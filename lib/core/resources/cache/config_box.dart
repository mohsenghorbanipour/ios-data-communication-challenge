import 'package:hive/hive.dart';

class ConfigBox {
  static const _boxName = 'zanis-config-box';

  static Future<void> setConfig(String key, String? value) async {
    LazyBox<String?> box;
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.lazyBox<String?>(_boxName);
    } else {
      box = await Hive.openLazyBox<String?>(_boxName);
    }
    box.put(key, value);
    return;
  }

  static Future<void> remove(String key) async {
    LazyBox<String> box;
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.lazyBox<String>(_boxName);
    } else {
      box = await Hive.openLazyBox<String>(_boxName);
    }
    box.delete(key);
    return;
  }

  static Future<String?> getConfig(String key) async {
    LazyBox<String?> box;
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.lazyBox<String?>(_boxName);
    } else {
      box = await Hive.openLazyBox<String?>(_boxName);
    }
    return box.get(key);
  }

  static Future<bool> contains(String key) async {
    LazyBox<String> box;
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.lazyBox<String>(_boxName);
    } else {
      box = await Hive.openLazyBox<String>(_boxName);
    }
    return box.containsKey(key);
  }
}

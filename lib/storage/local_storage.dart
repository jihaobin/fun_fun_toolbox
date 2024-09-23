import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const kGuessSpKey = "GUESS_CONFIG";

class LocalStorage {
  // 单例模式，保证类只能被实例化一次
  LocalStorage._();

  static LocalStorage? _storage;

  static LocalStorage get instance{
    _storage = _storage ?? LocalStorage._();
    return _storage!;
  }

  SharedPreferences? _prefs;

  Future<void> initSpWhenNull() async {
    if (_prefs != null) return;
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  Future<bool> saveGuess({
    required bool guessing,
    required int value,
  }) async {
    await initSpWhenNull();

    String content = json.encode({'guessing': guessing, 'value': value});
    return _prefs!.setString(kGuessSpKey, content);
  }

  Future<Map<String, dynamic>> getGuess() async {
    await initSpWhenNull();

    String? content = _prefs!.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }
}
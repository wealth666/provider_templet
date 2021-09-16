import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// 初始化必备操作 eg:user数据
  static late SharedPreferences prefs;

  static Future<bool> setItem<T>(String key, T data) {
    return prefs.setString(key, JsonMapper.serialize(data));
  }

  static T? getItem<T>(String key) {
    String? value = prefs.getString(key);
    return value != null ? JsonMapper.deserialize<T>(value) : null;
  }

  static Future<bool> delItem<T>(String key) {
    return prefs.remove(key);
  }

  static List<T> getList<T>(String key) {
    String? value = prefs.getString(key);
    return value != null
        ? jsonDecode(value).map<T>((item) => JsonMapper.deserialize<T>(item)).toList()
        : [];
  }

  static Future<void> setList<T>(String key, List<T> list) {
    return prefs.setString(key, JsonMapper.serialize(list));
  }

  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

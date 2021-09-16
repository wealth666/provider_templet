import 'package:dart_json_mapper/dart_json_mapper.dart';

class MyJsonMapping {
  static T? copyWith<T>(T object, T object2) {
    return JsonMapper.fromMap<T>(JsonMapper.toMap(object)!
      ..addAll(JsonMapper.toMap(object2)!
        ..removeWhere((key, value) => value == null)));
  }
}

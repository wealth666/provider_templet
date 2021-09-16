import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ResultData<T> {
  int code = 0;
  late String message;
  late T? data;
  late List<T>? list;
  late bool success;

  ResultData({code, message, success});

  ResultData.fromJson(Map<String, dynamic> json,
      {IJsonMapperAdapter? adapter, int? priority}) {
    code = json['errorCode'];
    message = json['errorMessage'];
    data = getObjectData(json['payload'], adapter: adapter, priority: priority);
    list = getListData(json['payload'], adapter: adapter, priority: priority);
    success = json['success'];
  }

  ResultData.fromError(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMessage'];
    data = json['payload'];
    success = json['success'];
  }

  T? getObjectData(dynamic data, {IJsonMapperAdapter? adapter, int? priority}) {
    if (data is List) {
      return null;
    }
    if (data is Map) {
      if (adapter != null) {
        JsonMapper().useAdapter(adapter, priority);
        return JsonMapper.deserialize(data);
      }
      return JsonMapper.fromMap<T>(data as Map<String, dynamic>);
    } else {
      return data;
    }
  }

  List<T> getListData(dynamic data,
      {IJsonMapperAdapter? adapter, int? priority}) {
    if (data is List) {
      if (adapter != null) {
        JsonMapper().useAdapter(adapter, priority);
        return JsonMapper.deserialize(data);
      }
      try {
        return data.map((item) => JsonMapper.fromMap<T>(item)!).toList();
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
    return [];
  }

  @override
  String toString() {
    return JsonMapper.serialize(this);
  }
}

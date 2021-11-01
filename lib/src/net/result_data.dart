import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ResultData<T> {
  int code = 0;
  String message = '';
  bool success = true;
  late T? data;
  late List<T>? list;

  ResultData(
      {required this.code,
      required this.message,
      required this.success,
      this.list,
      this.data});

  ResultData.fromJson(Map<String, dynamic> json,
      {IJsonMapperAdapter? adapter, int? priority}) {
    code = json['errorCode'];
    message = json['errorMessage'];
    data = getObjectData(json['payload']);
    list = getListData(json['payload']);
    success = json['success'];
  }

  ResultData.fromError(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMessage'];
    data = json['payload'];
    success = json['success'];
  }

  T? getObjectData(dynamic data) {
    if (data is List) {
      return null;
    }
    if (data is Map) {
      try {
        return JsonMapper.deserialize(data);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      return data;
    }
  }

  List<T> getListData(dynamic data) {
    if (data is List) {
      return data.map((item) {
        try {
          return JsonMapper.deserialize<T>(item)!;
        } catch (e) {
          // ignore: avoid_print
          print(e);
        }
        return {} as T;
      }).toList();
    }
    return [];
  }

  @override
  String toString() {
    return JsonMapper.serialize(this);
  }
}

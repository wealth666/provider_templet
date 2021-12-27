import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:provider_templet/provider_templet.dart';
import 'package:provider_templet/src/widget/provider_templet.dart';

@jsonSerializable
class ResultData<T> {
  int code = 0;
  String message = '';
  bool success = true;
  T? data;
  List<T>? list = [];

  ResultData(
      {required this.success,
      this.code = 0,
      this.message = '',
      this.list,
      this.data});

  ResultData.fromJson(Map<String, dynamic> json,
      {IJsonMapperAdapter? adapter, int? priority}) {
    ResponseData resData = ProviderTemplet.config.transformResData(json);
    code = resData.errorCode;
    message = resData.message;
    data = HttpUtils.getObjectData(resData.payload);
    list = HttpUtils.getListData(resData.payload);
    success = resData.success;
  }

  ResultData.fromError(Map<String, dynamic> json) {
    ResponseData resData = ProviderTemplet.config.transformResData(json);
    code = resData.errorCode;
    message = resData.message;
    data = resData.payload;
    success = resData.success;
  }

  @override
  String toString() {
    return JsonMapper.serialize(this);
  }
}

class ResponseData {
  int errorCode;
  String message;
  bool success;
  dynamic payload;

  ResponseData({
    required this.errorCode,
    required this.message,
    required this.success,
    required this.payload,
  });
}

import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'my_json_mapper.dart';

abstract class HttpParamViewModel<P> {
  notifyListeners();

  // 请求参数
  late P _params;

  set params(P params) {
    _params = params;
    notifyListeners();
  }

  setParams(P params) {
    this.params = params;
    return this;
  }

  P get params => _params;

  set copyParams(P params) {
    if (_params != null) {
      _params = MyJsonMapping.copyWith(_params, params)!;
    } else {
      _params = params;
    }
    notifyListeners();
  }

  Map<String, dynamic>? getParams({Map<String, dynamic>? params}) {
    Map<String, dynamic>? data =
        this.params != null ? JsonMapper.toMap(this.params) : null;
    if (params != null) {
      if (data != null) {
        data.addAll(params..removeWhere((key, value) => value == null));
      } else {
        data = params..removeWhere((key, value) => value == null);
      }
    }
    return data;
  }
}

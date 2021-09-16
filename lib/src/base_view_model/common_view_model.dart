import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';

import 'http_state_view_model.dart';

abstract class CommonViewModel extends HttpStateViewModel {

  Future<Response<Map>> prepare();

  IJsonMapperAdapter? jsonMapperAdapter() {
    return null;
  }
}

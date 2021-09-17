import 'package:dio/dio.dart';

import 'http_state_view_model.dart';

abstract class CommonViewModel extends HttpStateViewModel {

  Future<Response<Map>> prepare();

}

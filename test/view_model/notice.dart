import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:provider_templet/provider_templet.dart';

import '../api.dart';
import 'model/notice_model.dart';

class NoticeList extends ListViewModel<NoticeModel> {
  String get url => '/app/user/notice/list/1';

  @override
  IJsonMapperAdapter? jsonMapperAdapter() {
    return JsonMapperAdapter(valueDecorators: {
      typeOf<List<NoticeModel>>(): (value) => value.cast<NoticeModel>(),
    });
  }

  @override
  Future<Response<Map>> prepare() => dio.get<Map>(url);
}

class NoticeDetail extends ObjViewModel<NoticeModel>
    with HttpParamViewModel<NoticeRequest> {
  String get url => '/app/user/notice/${params.noticeID}';

  @override
  Future<Response<Map>> prepare() => dio.get<Map>(url);
}

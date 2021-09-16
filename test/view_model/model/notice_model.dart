import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable;

@jsonSerializable
class NoticeModel {
  // 公告ID
  late String noticeID;

  // 标题
  String? title;

  // 创建时间
  String? createTime;

  // 公告内容
  String? content;

  // 发布人
  String? creator;

  NoticeModel(this.noticeID);

  @override
  String toString() {
    return JsonMapper.serialize(this);
  }
}

class NoticeRequest {
  // 公告ID
  late String noticeID;

  NoticeRequest(this.noticeID);
}

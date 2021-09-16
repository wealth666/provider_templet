import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_templet/provider_templet.dart';
import 'provider_templet_test.reflectable.dart';
import 'view_model/model/notice_model.dart';
import 'view_model/notice.dart';

void main() {
  debugProfileBuildsEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  initializeReflectable();
  test('adds one to input values', () async {
    String noticeID = 'NFBm39651408314950';
    ResultData<NoticeModel> res =
        await NoticeDetail().setParams(NoticeRequest(noticeID)).load();
    print(res);
    /*final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);*/
  });
}

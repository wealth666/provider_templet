import 'package:provider_templet/src/net/result_data.dart';

import 'common_view_model.dart';
import 'http_param_view_model.dart';

abstract class SubmitViewModel<P, R> extends CommonViewModel
    with HttpParamViewModel<P> {
  // 返回值
  late R? _data;

  set data(R? data) {
    _data = data;
    notifyListeners();
  }

  R? get data => _data;

  void onFetchSuccess(R? data) {}

  void onFetchFail(ResultData res) {}

  Future<ResultData> submit({bool showMessage = true}) async {
    ResultData<R> resultData =
        await fetchResult<R>(prepare, adapter: jsonMapperAdapter());
    if (resultData.success) {
      data = resultData.data;
      onFetchSuccess(data);
    } else {
      onFetchFail(resultData);
    }
    return resultData;
  }
}

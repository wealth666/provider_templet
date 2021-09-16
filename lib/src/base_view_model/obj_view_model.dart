import 'package:provider_templet/src/net/result_data.dart';
import '../manager/storage_manager.dart';

import 'common_view_model.dart';

abstract class ObjViewModel<R> extends CommonViewModel {
  // 返回值
  late R? _data;

  String? localKey;

  ObjViewModel() {
    if (localKey != null) {
      _data = StorageManager.getItem<R>(localKey!);
    }
  }

  set data(R? data) {
    _data = data;
    notifyListeners();
  }

  R? get data => _data;

  void onFetchSuccess(R? data) {}

  void onFetchFail(ResultData res) {}

  Future<ResultData<R>> load() async {
    ResultData<R> resultData =
        await fetchResult<R>(prepare, adapter: jsonMapperAdapter());
    if (resultData.success) {
      data = resultData.data;
      if (localKey != null) {
        StorageManager.setItem(localKey!, data);
      }
      onFetchSuccess(data);
    } else {
      onFetchFail(resultData);
    }
    return resultData;
  }
}

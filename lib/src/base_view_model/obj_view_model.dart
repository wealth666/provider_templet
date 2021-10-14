import 'package:provider_templet/src/base_view_model/http_load_state_view_model.dart';
import 'package:provider_templet/src/manager/storage_manager.dart';
import 'package:provider_templet/src/net/result_data.dart';

abstract class ObjViewModel<R> extends HttpLoadStateViewModel {
  // 返回值
  late R _data;

  String? localKey;

  ObjViewModel() {
    if (localKey != null) {
      _data = StorageManager.getItem<R>(localKey!) ?? null;
    }
  }

  set data(R data) {
    _data = data;
    notifyListeners();
  }

  R get data => _data;

  void onFetchSuccess(R data) {}

  void onFetchFail(ResultData res) {}

  @override
  Future<ResultData<R>> refresh({bool setState = false}) {
    return load(setState: setState);
  }

  @override
  Future<ResultData<R>> load(
      {bool defaultSet = true, bool setState = true}) async {
    ResultData<R> resultData =
    await fetchResult<R>(prepare, setState: setState);
    if (resultData.success) {
      if (defaultSet) {
        data = resultData.data!;
        if (localKey != null) {
          StorageManager.setItem(localKey!, data);
        }
      }
      onFetchSuccess(data);
    } else {
      onFetchFail(resultData);
    }
    return resultData;
  }
}

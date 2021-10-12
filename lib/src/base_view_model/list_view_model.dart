import 'package:provider_templet/src/base_view_model/http_load_state_view_model.dart';
import 'package:provider_templet/src/net/result_data.dart';
import 'package:provider_templet/src/manager/storage_manager.dart';

abstract class ListViewModel<R> extends HttpLoadStateViewModel {
  // 返回值
  List<R> list = [];

  String? localKey;

  ListViewModel() {
    if (localKey != null) {
      list = StorageManager.getList<R>(localKey!);
    }
  }

  void onFetchSuccess(List<R> list) {}

  void onFetchFail(ResultData res) {}

  @override
  Future<ResultData<R>> refresh() {
    return load(setState: false);
  }

  @override
  Future<ResultData<R>> load(
      {bool defaultSet = true, bool setState = true}) async {
    ResultData<R> resultData = await fetchList<R>(prepare, setState: setState);
    if (resultData.success) {
      if (resultData.list == null || resultData.list!.isEmpty) {
        setEmpty();
      }
      if (defaultSet) {
        list = resultData.list ?? [];
        if (localKey != null) {
          StorageManager.setList(localKey!, list);
        }
        notifyListeners();
      }
      onFetchSuccess(list);
    } else {
      onFetchFail(resultData);
    }
    return resultData;
  }
}

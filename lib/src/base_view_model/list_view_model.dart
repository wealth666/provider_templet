import 'package:provider_templet/src/net/result_data.dart';
import 'package:provider_templet/src/manager/storage_manager.dart';

import 'common_view_model.dart';

abstract class ListViewModel<R> extends CommonViewModel {
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

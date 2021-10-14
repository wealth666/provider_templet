import '../../provider_templet.dart';
import 'common_view_model.dart';

abstract class HttpLoadStateViewModel<R> extends CommonViewModel {
  // 加载数据
  Future<ResultData<R>> load({bool defaultSet, bool setState});

  // 刷新数据
  Future<ResultData<R>> refresh({bool setState});
}

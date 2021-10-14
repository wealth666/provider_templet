import 'package:provider_templet/src/net/result_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_view_model.dart';

abstract class RefreshViewModel<R> extends ListViewModel<R> {
  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  int pageSize = 30;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  @override
  Future<ResultData<R>> load(
      {bool defaultSet = true, bool setState = true}) async {
    return pullRefresh(init: true);
  }

  @override
  Future<ResultData<R>> refresh({bool setState = false}) async {
    return pullRefresh(init: setState);
  }

  Future<ResultData<R>> pullRefresh({bool init = false}) async {
    _currentPageNum = pageNumFirst;
    refreshController.resetNoData();
    ResultData<R> res = await super.load(defaultSet: false, setState: init);
    if (res.success) {
      if (res.list!.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
      } else {
        list.clear();
        list.addAll(res.list!);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if (res.list!.length < pageSize) {
        } else {
          // 防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
      }
      onFetchSuccess(list);
    } else {
      onFetchFail(res);
      if (init) list.clear();
      refreshController.refreshFailed();
    }
    notifyListeners();
    return res;
  }

  /// 上拉加载更多
  Future<ResultData> loadMore() async {
    ++_currentPageNum;
    ResultData<R> res = await load(defaultSet: false, setState: false);
    if (res.success) {
      if (res.list!.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        list.addAll(res.list!);
        if (res.list!.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
    } else {
      _currentPageNum--;
      refreshController.loadFailed();
    }
    notifyListeners();
    return res;
  }

  Map<String, dynamic> getPageParams() {
    return {}..addAll({'page': _currentPageNum, 'pageSize': pageSize});
  }
}

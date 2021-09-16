import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_templet/src/net/http_util.dart';
import 'package:provider_templet/src/net/result_data.dart';

import 'model/view_state.dart';

class HttpStateViewModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  HttpStateViewModel({ViewState? viewState})
      : _viewState = viewState ?? ViewState.idle {
    debugPrint('ViewStateModel---constructor--->$runtimeType');
  }

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setError() {
    viewState = ViewState.error;
  }

  Future<ResultData<T>> fetchResult<T>(Future<Response> Function() fetch,
      {bool setState = true,
      IJsonMapperAdapter? adapter,
      int? priority}) async {
    if (setState) {
      setBusy();
    }
    return HttpUtils.fetchResult<T>(() => fetch(), successCallback: (T? data) {
      if (setState) {
        setIdle();
      }
    }, errorCallback: (int code, String message) {
      if (setState) {
        setError();
      }
    });
  }

  Future<ResultData<T>> fetchList<T>(Future<Response> Function() fetch,
      {bool setState = true,
      IJsonMapperAdapter? adapter,
      int? priority}) async {
    if (setState) {
      setBusy();
    }
    return HttpUtils.fetchList<T>(() => fetch(),
        successCallback: (List<T>? data) {
      if (setState) {
        setIdle();
      }
    }, errorCallback: (int code, String message) {
      if (setState) {
        setError();
      }
    });
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

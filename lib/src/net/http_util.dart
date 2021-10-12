import 'package:dio/dio.dart';
import 'package:provider_templet/src/net/result_data.dart';

class HttpUtils {
  static Future<ResultData<T>> fetchResult<T>(Future<Response> Function() fetch,
      {Function(T? data)? successCallback,
      Function(int statusCode, String errorMessage)? errorCallback}) async {
    try {
      Response result = await fetch();
      ResultData<T> dataResult = ResultData<T>.fromJson(result.data);
      if (successCallback != null) {
        successCallback(dataResult.data);
      }
      return dataResult;
    } catch (e, s) {
      return handleError<T>(e, s, errorCallback: errorCallback);
    }
  }

  static Future<ResultData<T>> fetchList<T>(Future<Response> Function() fetch,
      {Function(List<T>? data)? successCallback,
      Function(int statusCode, String errorMessage)? errorCallback}) async {
    try {
      Response result = await fetch();
      ResultData<T> dataResult = ResultData<T>.fromJson(result.data);
      if (successCallback != null) {
        successCallback(dataResult.list);
      }
      return dataResult;
    } catch (e, s) {
      return handleError<T>(e, s, errorCallback: errorCallback);
    }
  }

  static ResultData<T> handleError<T>(e, stackTrace,
      {Function(int statusCode, String errorMessage)? errorCallback}) {
    int errorCode = -1000;
    String message = '系统异常！';
    // ignore: avoid_print
    print(e);
    if (e is DioError && e.response != null) {
      ResultData<T> result = ResultData<T>.fromError(e.response?.data ?? {});
      message = result.message;
      errorCode = result.code;
      if (e.response?.statusCode == 400) {
        return result;
      } else if (e.response?.statusCode == 401) {
        throw e;
      }
    }
    if (errorCallback != null) {
      errorCallback(errorCode, message);
    }
    return ResultData(success: false, code: errorCode, message: message);
  }
}

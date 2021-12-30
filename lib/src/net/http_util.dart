import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:provider_templet/src/net/result_data.dart';
import 'package:provider_templet/src/widget/provider_templet.dart';

class HttpUtils {
  static Future<ResultData<T>> fetchResult<T>(Future<Response> Function() fetch,
      {Function(T? data)? successCallback,
      Function(int statusCode, String? errorMessage)? errorCallback}) async {
    try {
      Response result = await fetch();
      ResultData<T> dataResult = ResultData<T>.fromJson(result.data);
      if (successCallback != null) {
        successCallback(dataResult.data);
      }
      return dataResult;
    } catch (e, s) {
      return ProviderTemplet.config.handleResError(e, s, errorCallback: errorCallback);
    }
  }

  static Future<ResultData<T>> fetchList<T>(Future<Response> Function() fetch,
      {Function(List<T>? data)? successCallback,
      Function(int statusCode, String? errorMessage)? errorCallback}) async {
    try {
      Response result = await fetch();
      ResultData<T> dataResult = ResultData<T>.fromJson(result.data);
      if (successCallback != null) {
        successCallback(dataResult.list);
      }
      return dataResult;
    } catch (e, s) {
      return ProviderTemplet.config.handleResError<T>(e, s, errorCallback: errorCallback);
    }
  }

  static T? getObjectData<T>(dynamic data) {
    if (data is List) {
      return null;
    }
    if (data is Map) {
      try {
        return JsonMapper.deserialize(data);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      return data;
    }
  }

  static List<T> getListData<T>(dynamic data) {
    if(data!=null){
      if (data is List) {
        return data.map((item) {
          try {
            return JsonMapper.deserialize<T>(item)!;
          } catch (e) {
            print(item);
            // ignore: avoid_print
            print(e);
          }
          return {} as T;
        }).toList();
      }
    }
    return [];
  }
}

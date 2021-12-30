import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_templet/provider_templet.dart';
import 'package:provider_templet/src/net/result_data.dart';

abstract class ConfigProcessor {
  ResponseData transformResData(Map<String, dynamic> json);

  ResultData<T> handleResError<T>(e, stackTrace,
      {Function(int statusCode, String? errorMessage)? errorCallback});

  void handleError(Response response, ResultData? result);

  String systemErrorMessage() {
    return 'The request failed. Please check the network!';
  }
}

class BaseConfigProcessor extends ConfigProcessor {
  @override
  ResponseData transformResData(Map<String, dynamic> json) {
    int? errorCode = json['errorCode'];
    String? errorMessage = json['errorMessage'];
    dynamic payload = json['payload'];
    bool success = json['success'] ?? false;

    return ResponseData(
      errorCode: errorCode,
      message: errorMessage,
      payload: payload,
      success: success,
    );
  }

  @override
  void handleError(Response<dynamic> response, ResultData<dynamic>? result) {}

  @override
  ResultData<T> handleResError<T>(e, stackTrace,
      {Function(int statusCode, String? errorMessage)? errorCallback}) {
    int? errorCode;
    String? message = ProviderTemplet.config.systemErrorMessage();
    debugPrint(stackTrace.toString());
    ResultData<T>? result;
    if (e is DioError && e.response != null) {
      if (e.response?.data is Map) {
        result = ResultData<T>.fromError(e.response?.data ?? {});
        message = result.message;
        errorCode = result.code;
        ProviderTemplet.config.handleError(e.response!, result);
      } else if (e.response?.data is String) {
        message = e.response?.data;
        errorCode = e.response?.statusCode;
      }
      ProviderTemplet.config.handleError(e.response!, result);
    }
    if (errorCallback != null) {
      errorCallback(errorCode ?? -1000, message);
    }
    result =
        ResultData(success: false, code: errorCode ?? -1000, message: message);
    return result;
  }
}

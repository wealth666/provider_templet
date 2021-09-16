import 'package:dio/dio.dart';

var dio = Dio(BaseOptions(
  baseUrl: "http://m-dev.cs.com.local",
  connectTimeout: 5000,
  receiveTimeout: 5000,
));

import 'package:dio/dio.dart';
import 'dart:io';

class HttpManager extends Dio {
  static const String CONTENT_TYPE_PRIMARY = "application";

  //static const String CONTENT_TYPE_FORM = "x-www-form-urlencoded"; // MediaType.parse("application/json; charset=UTF-8");
  static const String CONTENT_TYPE_JSON = "json";
  static const String CONTENT_CHART_SET = 'utf-8';

  // 工厂模式
  factory HttpManager() => _getInstance();

  static HttpManager get instance => _getInstance();
  static HttpManager _instance;

  HttpManager._internal();

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
      BaseOptions options = BaseOptions(
          // 15s 超时时间
          connectTimeout: 30000,
          receiveTimeout: 30000,
          responseType: ResponseType.json,
          contentType: ContentType(CONTENT_TYPE_PRIMARY, CONTENT_TYPE_JSON,
              charset: CONTENT_CHART_SET));
      _instance.options = options;
    }
    return _instance;
  }
}

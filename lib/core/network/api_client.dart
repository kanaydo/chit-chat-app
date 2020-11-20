import 'package:dio/dio.dart';
//import 'package:flutter_base_app/core/network/logging_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiClient {

  var _dio = new Dio();
  //var _interceptor = LoggingInterceptor();

  ApiClient() {
    _dio.options.headers['content-Type'] = 'application/json';
    //_dio.options.headers["authorization"] = 'Token ${DotEnv().env['ACCESS_TOKEN']}';
    _dio.options.baseUrl = '${DotEnv().env['API_ROOT']}/';
    //_dio.interceptors.add(_interceptor);
    _dio.options.connectTimeout = 10*10000;
  }

  Dio get dio => _dio;

}
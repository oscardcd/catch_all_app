import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  static const _key = '';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({'api_key': _key});
    super.onRequest(options, handler);
  }
}

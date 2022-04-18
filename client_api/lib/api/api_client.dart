import 'package:client_api/api/request.dart';
import 'package:dio/dio.dart';

import 'model/api_result.dart';

class ApiClient {
  ApiClient._privateConstructor();
  static final ApiClient _instance = ApiClient._privateConstructor();

  static ApiClient get instance => _instance;
  late Dio dio;

  void init({
    required String baseUrl,
    required Map<String, Object> headers,
    List<Interceptor>? interceptors,
  }) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: 6000,
      receiveTimeout: 5000,
    ));

    if (interceptors != null) {
      _instance.dio.interceptors.addAll(interceptors);
    }
  }

  Future<ApiResult<T>> request<T>(
      ApiRequest request, Function(dynamic) fromJson) async {
    try {
      final response = await _instance.dio.request(request.url,
          data: request.body,
          queryParameters: request.query,
          options: Options(method: request.method, headers: request.headers));
      return ApiResult.success(data: fromJson(response.data));
    } on Exception catch (e) {
      return ApiResult.failure(error: e);
    }
  }
}

import 'package:client_api/api/http_methods.dart';

class ApiRequest {
  final String url;
  final String method;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? headers;
  final dynamic body;

  ApiRequest(
      {required this.url,
      required this.method,
      this.query,
      this.headers,
      this.body});

  factory ApiRequest.get(
    String url, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) {
    return ApiRequest(
      url: url,
      method: HttpMethods.get,
      headers: headers,
      query: query,
    );
  }

  factory ApiRequest.post(
    String url, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    return ApiRequest(
        url: url,
        method: HttpMethods.post,
        headers: headers,
        query: query,
        body: body);
  }

  factory ApiRequest.put(
    String url, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    return ApiRequest(
        url: url,
        method: HttpMethods.put,
        headers: headers,
        query: query,
        body: body);
  }

  factory ApiRequest.patch(
    String url, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    return ApiRequest(
        url: url,
        method: HttpMethods.patch,
        headers: headers,
        query: query,
        body: body);
  }

  factory ApiRequest.delete(
    String url, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) {
    return ApiRequest(
      url: url,
      method: HttpMethods.delete,
      headers: headers,
      query: query,
    );
  }
}

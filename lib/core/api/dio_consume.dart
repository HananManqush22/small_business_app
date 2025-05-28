import 'package:dio/dio.dart';
import 'package:small_business_app/core/api/api_Consumer.dart';
import 'package:small_business_app/core/api/api_interceptors.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/core/errors/exception.dart';

class DioConsume extends ApiConsumer {
  final Dio dio;

  DioConsume({required this.dio}) {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true));
  }

  @override
  Future delete({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(url,
          queryParameters: query,
          data: isFormData ? FormData.fromMap(data) : data);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future get({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: query, data: data);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future patch({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(url,
          queryParameters: query,
          data: isFormData ? FormData.fromMap(data) : data);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future post({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(url,
          queryParameters: query,
          data: isFormData ? FormData.fromMap(data) : data);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }
}

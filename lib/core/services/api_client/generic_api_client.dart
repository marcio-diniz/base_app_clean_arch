import 'dart:io';

import 'package:base_app_clean_arch/core/environment/api_source.dart';
import 'package:base_app_clean_arch/core/services/api_client/api_client_response.dart';
import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:dio/dio.dart';

import '../../environment/i_environment_manager.dart';

class GenericApiClient implements IApiClient {
  GenericApiClient({required this.environmentManager});

  final IEnvironmentManager environmentManager;

  final dio = Dio();

  @override
  Future<ApiClientResponse<T>> get<T>({
    required String route,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    if (headers != null) {
      dio.options.headers = headers;
    }
    return _handleDioException(
      () => dio.get(
        route,
        queryParameters: queryParameters,
        options: Options(validateStatus: (status) => true),
      ),
    );
  }

  @override
  Future<ApiClientResponse<T>> put<T>({
    required String route,
    Object? requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    if (headers != null) {
      dio.options.headers = headers;
    }
    return _handleDioException(
      () => dio.put(
        route,
        data: requestBody,
        queryParameters: queryParameters,
        options: Options(validateStatus: (status) => true),
      ),
    );
  }

  @override
  Future<ApiClientResponse<T>> post<T>({
    required String route,
    Object? requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    if (headers != null) {
      dio.options.headers = headers;
    }
    return _handleDioException(
      () => dio.post(
        route,
        data: requestBody,
        queryParameters: queryParameters,
        options: Options(validateStatus: (status) => true),
      ),
    );
  }

  @override
  Future<ApiClientResponse<T>> delete<T>({
    required String route,
    Object? requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ApiSource apiSource = ApiSource.argus,
  }) async {
    if (headers != null) {
      dio.options.headers = headers;
    }
    return _handleDioException(
      () => dio.delete(
        route,
        data: requestBody,
        queryParameters: queryParameters,
        options: Options(validateStatus: (status) => true),
      ),
    );
  }

  Future<ApiClientResponse<T>> _handleDioException<T>(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return ApiClientResponse<T>(
        statusCode: response.statusCode ?? 0,
        data: response.data,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const SocketException('No Internet connection');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

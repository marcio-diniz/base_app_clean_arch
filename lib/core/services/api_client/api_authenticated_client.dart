import 'dart:io';

import 'package:base_app_clean_arch/core/environment/i_environment_manager.dart';
import 'package:base_app_clean_arch/core/services/api_client/api_authentication_interceptor.dart';
import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/core/services/auth_token/i_auth_token_service.dart';
import 'package:dio/dio.dart';

import 'api_client_response.dart';

class ApiAuthenticatedClient implements IApiClient {
  ApiAuthenticatedClient({
    required this.environmentManager,
    required this.authTokenService,
  });

  final IEnvironmentManager environmentManager;
  final IAuthTokenService authTokenService;

  final dio = Dio();

  @override
  Future<ApiClientResponse<T>> get<T>({
    required String route,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final urlBase = environmentManager.getApiRoute();

    if (headers != null) {
      dio.options.headers = headers;
    }

    dio.interceptors.add(
      ApiAuthenticationInterceptor(authTokenService: authTokenService),
    );

    return _handleDioException(
      () => dio.get(
        '$urlBase/$route',
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
    final urlBase = environmentManager.getApiRoute();

    if (headers != null) {
      dio.options.headers = headers;
    }

    dio.interceptors.add(
      ApiAuthenticationInterceptor(authTokenService: authTokenService),
    );

    return _handleDioException(
      () => dio.put(
        '$urlBase/$route',
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
    final urlBase = environmentManager.getApiRoute();

    if (headers != null) {
      dio.options.headers = headers;
    }

    dio.interceptors.add(
      ApiAuthenticationInterceptor(authTokenService: authTokenService),
    );

    return _handleDioException(
      () => dio.post(
        '$urlBase/$route',
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
  }) async {
    final urlBase = environmentManager.getApiRoute();

    if (headers != null) {
      dio.options.headers = headers;
    }

    dio.interceptors.add(
      ApiAuthenticationInterceptor(authTokenService: authTokenService),
    );

    return _handleDioException(
      () => dio.delete(
        '$urlBase/$route',
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

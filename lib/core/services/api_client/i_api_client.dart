import 'api_client_response.dart';

abstract class IApiClient {
  Future<ApiClientResponse<T>> get<T>({
    required String route,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<ApiClientResponse<T>> put<T>({
    required String route,
    Object? requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<ApiClientResponse<T>> post<T>({
    required String route,
    Object? requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<ApiClientResponse<T>> delete<T>({
    required String route,
    Object? requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}

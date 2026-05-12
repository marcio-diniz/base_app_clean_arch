import 'package:base_app_clean_arch/core/services/auth_token/i_auth_token_service.dart';
import 'package:dio/dio.dart';

class ApiAuthenticationInterceptor extends Interceptor {
  const ApiAuthenticationInterceptor({
    required IAuthTokenService authTokenService,
  }) : _authTokenService = authTokenService;

  final IAuthTokenService _authTokenService;
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authTokenService.ensureValidToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

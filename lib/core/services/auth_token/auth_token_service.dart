import 'package:base_app_clean_arch/core/environment/i_environment_manager.dart';
import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/core/services/auth_token/i_auth_token_service.dart';
import 'package:base_app_clean_arch/data/model/refresh_token_response_model.dart';
import '../../auth/i_auth_manager.dart';
import '../../error/exceptions.dart';

class AuthTokenService implements IAuthTokenService {
  AuthTokenService({
    required IAuthManager customAuthManager,
    required IEnvironmentManager environmentManager,
    required IApiClient apiClient,
  }) : _customAuthManager = customAuthManager,
       _environmentManager = environmentManager,
       _apiClient = apiClient;

  final IAuthManager _customAuthManager;
  final IEnvironmentManager _environmentManager;
  final IApiClient _apiClient;

  @override
  Future<String?> ensureValidToken() async {
    try {
      final currentToken = _customAuthManager.currentAuthenticationToken;
      final shouldRefresh =
          currentToken == null ||
          (_customAuthManager.tokenExpiration?.isBefore(DateTime.now()) ??
              true);

      if (shouldRefresh) {
        final response = await _refreshAndPersistToken();
        return response.accessToken;
      }
      return currentToken;
    } catch (e) {
      return null;
    }
  }

  Future<RefreshTokenResponseModel> _refreshAndPersistToken() async {
    final refreshTokenResponse = await requestNewAuthToken();
    await _customAuthManager.refreshToken(
      authenticationToken: refreshTokenResponse.accessToken,
      expiresIn: refreshTokenResponse.expiresIn,
    );
    return refreshTokenResponse;
  }

  @override
  Future<RefreshTokenResponseModel> requestNewAuthToken() async {
    try {
      final currentRefreshToken =
          _customAuthManager.currentRefreshAuthenticationToken;
      final countryCode = _customAuthManager.countryCode;
      final phoneNumber = _customAuthManager.phoneNumber;

      if (currentRefreshToken != null && phoneNumber != null) {
        final urlBase = _environmentManager.getApiRoute();
        final body = {
          "phone": countryCode + phoneNumber,
          "refresh_token": currentRefreshToken,
        };

        final response = await _apiClient.post(
          route: '$urlBase/auth/refresh_token',
          requestBody: body,
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          final model = RefreshTokenResponseModel.maybeFromMap(response.data);
          if (model != null) {
            return model;
          }
        }
      }
      throw Exception();
    } catch (e) {
      throw RefreshTokenException();
    }
  }
}

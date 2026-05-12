import '../../../data/model/refresh_token_response_model.dart';

abstract class IAuthTokenService {
  Future<String?> ensureValidToken();

  Future<RefreshTokenResponseModel> requestNewAuthToken();
}

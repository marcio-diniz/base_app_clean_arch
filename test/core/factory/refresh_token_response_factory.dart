import 'package:base_app_clean_arch/data/model/refresh_token_response_model.dart';
import 'package:base_app_clean_arch/domain/entity/refresh_token_response_entity.dart';

class RefreshTokenResponseFactory {
  final String accessToken = 'refresh_token_access_token';
  final int expiresIn = 3600;

  RefreshTokenResponseEntity createEntity() {
    return RefreshTokenResponseEntity(
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }

  RefreshTokenResponseModel createModel() {
    return RefreshTokenResponseModel(
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }

  Map<String, dynamic> createMap() {
    return {'access_token': accessToken, 'expires_in': expiresIn};
  }
}

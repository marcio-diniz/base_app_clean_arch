import 'package:base_app_clean_arch/data/model/sign_in_response_model.dart';
import 'package:base_app_clean_arch/domain/entity/sign_in_response_entity.dart';

class SignInResponseFactory {
  final String userId = 'account_id';
  final String accessToken = 'access_token';
  final String refreshToken = 'refresh_token';
  final int expiresIn = 3600;

  SignInResponseEntity createEntity() {
    return SignInResponseEntity(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }

  SignInResponseModel createModel() {
    return SignInResponseModel(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }

  Map<String, dynamic> createMap() {
    return {
      'user_id': userId,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
    };
  }
}

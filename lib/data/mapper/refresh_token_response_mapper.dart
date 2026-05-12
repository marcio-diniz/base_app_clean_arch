import '../../domain/entity/refresh_token_response_entity.dart';
import '../model/refresh_token_response_model.dart';

extension RefreshTokenResponseModelToEntityMapper on RefreshTokenResponseModel {
  RefreshTokenResponseEntity toRefreshTokenResponseEntity() {
    return RefreshTokenResponseEntity(
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }
}

extension RefreshTokenResponseEntityToModelMapper
    on RefreshTokenResponseEntity {
  RefreshTokenResponseModel toRefreshTokenResponseModel() {
    return RefreshTokenResponseModel(
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }
}

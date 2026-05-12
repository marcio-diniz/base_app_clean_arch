import '../../domain/entity/sign_in_response_entity.dart';
import '../model/sign_in_response_model.dart';

extension SignInResponseModelToEntityMapper on SignInResponseModel {
  SignInResponseEntity toSignInResponseEntity() {
    return SignInResponseEntity(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}

extension SignInResponseEntityToModelMapper on SignInResponseEntity {
  SignInResponseModel toSignInResponseModel() {
    return SignInResponseModel(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}

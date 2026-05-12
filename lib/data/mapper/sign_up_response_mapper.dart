import '../../domain/entity/sign_up_response_entity.dart';
import '../model/sign_up_response_model.dart';

extension SignUpResponseModelToEntityMapper on SignUpResponseModel {
  SignUpResponseEntity toSignUpResponseEntity() {
    return SignUpResponseEntity(
      userId: userId,
    );
  }
}

extension SignUpResponseEntityToModelMapper on SignUpResponseEntity {
  SignUpResponseModel toSignUpResponseModel() {
    return SignUpResponseModel(
      userId: userId,
    );
  }
}

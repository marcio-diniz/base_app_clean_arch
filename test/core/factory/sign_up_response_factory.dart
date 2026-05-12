import 'package:base_app_clean_arch/data/model/sign_up_response_model.dart';
import 'package:base_app_clean_arch/domain/entity/sign_up_response_entity.dart';

class SignUpResponseFactory {
  final String userId = 'user_id';

  SignUpResponseEntity createEntity() {
    return SignUpResponseEntity(userId: userId);
  }

  SignUpResponseModel createModel() {
    return SignUpResponseModel(userId: userId);
  }

  Map<String, dynamic> createMap() {
    return {'UserSub': userId};
  }
}

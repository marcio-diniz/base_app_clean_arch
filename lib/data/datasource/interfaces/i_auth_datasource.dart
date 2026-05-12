import '../../../domain/enums/send_code_type_enum.dart';
import '../../model/refresh_token_response_model.dart';
import '../../model/sign_in_response_model.dart';
import '../../model/sign_up_response_model.dart';

abstract class IAuthDatasource {
  Future<SignUpResponseModel> signUp({
    required String phone,
    required String password,
    required int termsVersion,
    required int privacyPolicyVersion,
  });

  Future<SignInResponseModel> signIn({
    required String phone,
    required String password,
  });

  Future<RefreshTokenResponseModel> refreshToken();

  Future<void> forgotPassword({
    required String phone,
  });

  Future<void> resendForgotPasswordCode({
    required String phone,
    required SendCodeTypeEnum sendCodeType,
  });

  Future<void> confirmForgotPassword({
    required String phone,
    required String password,
    required String confirmationCode,
  });

  Future<void> signOut();
}

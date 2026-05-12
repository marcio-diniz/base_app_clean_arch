import 'package:base_app_clean_arch/domain/enums/send_code_type_enum.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repository/i_auth_repository.dart';
import 'i_resend_forgot_password_code_use_case.dart';

class ResendForgotPasswordCodeUseCase
    implements IResendForgotPasswordCodeUseCase {
  const ResendForgotPasswordCodeUseCase({required this.authRepository});
  final IAuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({
    required String? phone,
    required SendCodeTypeEnum sendCodeType,
  }) async {
    if (phone == null) {
      return const Left(InputOfApplicationFailure());
    }
    return authRepository.resendForgotPasswordCode(
      phone: phone,
      sendCodeType: sendCodeType,
    );
  }
}

import 'package:base_app_clean_arch/domain/entity/refresh_token_response_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entity/sign_in_response_entity.dart';
import '../entity/sign_up_response_entity.dart';
import '../enums/send_code_type_enum.dart';

abstract class IAuthRepository {
  Future<Either<Failure, SignUpResponseEntity>> signUp({
    required String phone,
    required String password,
    required int termsVersion,
    required int privacyPolicyVersion,
  });

  Future<Either<Failure, SignInResponseEntity>> signIn({
    required String phone,
    required String password,
  });

  Future<Either<Failure, RefreshTokenResponseEntity>> refreshToken();

  Future<Either<Failure, void>> forgotPassword({required String phone});

  Future<Either<Failure, void>> resendForgotPasswordCode({
    required String phone,
    required SendCodeTypeEnum sendCodeType,
  });

  Future<Either<Failure, void>> changePassword({
    required String phone,
    required String password,
    required String confirmationCode,
  });

  Future<Either<Failure, void>> signOut();
}

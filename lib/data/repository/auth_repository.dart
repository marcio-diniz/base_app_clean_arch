import 'package:base_app_clean_arch/data/datasource/interfaces/i_auth_datasource.dart';
import 'package:base_app_clean_arch/data/mapper/refresh_token_response_mapper.dart';
import 'package:base_app_clean_arch/data/mapper/sign_in_response_mapper.dart';
import 'package:base_app_clean_arch/data/mapper/sign_up_response_mapper.dart';
import 'package:base_app_clean_arch/domain/entity/refresh_token_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entity/sign_in_response_entity.dart';
import '../../domain/entity/sign_up_response_entity.dart';
import '../../domain/enums/send_code_type_enum.dart';
import 'handle_error/i_handle_error_on_request.dart';
import '../../domain/repository/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  const AuthRepository({
    required this.authDatasource,
    required this.handleRequestOrErrors,
  });

  final IAuthDatasource authDatasource;
  final IHandleErrorOnRequest handleRequestOrErrors;

  @override
  Future<Either<Failure, SignUpResponseEntity>> signUp({
    required String phone,
    required String password,
    required int termsVersion,
    required int privacyPolicyVersion,
  }) async => await handleRequestOrErrors<SignUpResponseEntity>(
    () async {
      final result = await authDatasource.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      );
      return result.toSignUpResponseEntity();
    },
    defaultMessageFailure: signUpFailureMessage,
    additionalValidationFailures: <Exception, Failure>{
      AlreadyPhoneException(): const AlreadyPhoneFailure(
        message: signUpAlreadyPhoneFailureMessage,
      ),
      PaymentRequiredException(): const PaymentRequiredFailure(),
    },
  );

  @override
  Future<Either<Failure, SignInResponseEntity>> signIn({
    required String phone,
    required String password,
  }) async => await handleRequestOrErrors<SignInResponseEntity>(
    () async {
      final result = await authDatasource.signIn(
        phone: phone,
        password: password,
      );
      return result.toSignInResponseEntity();
    },
    defaultMessageFailure: signInFailureMessage,
    additionalValidationFailures: <Exception, Failure>{
      UnauthorizedException(): const UnauthorizedFailure(
        message: phoneOrPasswordInvalidFailureMessage,
      ),
    },
  );

  @override
  Future<Either<Failure, RefreshTokenResponseEntity>> refreshToken() async =>
      await handleRequestOrErrors<RefreshTokenResponseEntity>(() async {
        final result = await authDatasource.refreshToken();
        return result.toRefreshTokenResponseEntity();
      }, defaultMessageFailure: refreshTokenFailureMessage);

  @override
  Future<Either<Failure, void>> forgotPassword({required String phone}) async =>
      await handleRequestOrErrors<void>(
        () async {
          return await authDatasource.forgotPassword(phone: phone);
        },
        defaultMessageFailure: forgotPasswordFailureMessage,
        additionalValidationFailures: <Exception, Failure>{
          NotFoundException(): const NotFoundFailure(
            message: accountPhoneNotFoundFailureMessage,
          ),
        },
      );

  @override
  Future<Either<Failure, void>> resendForgotPasswordCode({
    required String phone,
    required SendCodeTypeEnum sendCodeType,
  }) async => await handleRequestOrErrors<void>(
    () async {
      return await authDatasource.resendForgotPasswordCode(
        phone: phone,
        sendCodeType: sendCodeType,
      );
    },
    defaultMessageFailure: forgotPasswordFailureMessage,
    additionalValidationFailures: <Exception, Failure>{
      NotFoundException(): const NotFoundFailure(
        message: accountPhoneNotFoundFailureMessage,
      ),
    },
  );

  @override
  Future<Either<Failure, void>> changePassword({
    required String phone,
    required String password,
    required String confirmationCode,
  }) async => await handleRequestOrErrors<void>(
    () async {
      return await authDatasource.confirmForgotPassword(
        phone: phone,
        password: password,
        confirmationCode: confirmationCode,
      );
    },
    defaultMessageFailure: confirmationForgotPasswordFailureMessage,
    additionalValidationFailures: <Exception, Failure>{
      NotFoundException(): const NotFoundFailure(
        message: accountPhoneNotFoundFailureMessage,
      ),
      InvalidInputException(): const InputOfApplicationFailure(
        message: invalidConfirmationCodeFailureMessage,
      ),
    },
  );

  @override
  Future<Either<Failure, void>> signOut() async =>
      await handleRequestOrErrors<void>(() async {
        return await authDatasource.signOut();
      }, defaultMessageFailure: signOutFailureMessage);
}

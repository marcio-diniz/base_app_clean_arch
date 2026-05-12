import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/data/datasource/handle_datasource_exception/i_handle_datasource_exception.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/i_handle_status_code_error.dart';
import 'package:base_app_clean_arch/data/model/refresh_token_response_model.dart';
import 'package:base_app_clean_arch/data/model/sign_up_response_model.dart';
import '../../core/auth/i_auth_manager.dart';

import '../../core/error/exceptions.dart';
import '../../core/services/auth_token/i_auth_token_service.dart';
import '../../domain/enums/send_code_type_enum.dart';
import '../model/sign_in_response_model.dart';
import 'interfaces/i_auth_datasource.dart';

class AuthDatasource implements IAuthDatasource {
  const AuthDatasource({
    required this.handleStatusCodeError,
    required this.handleDatasourceException,
    required this.customAuthManager,
    required this.tokenService,
    required this.argusApiClient,
  });
  final IHandleStatusCodeError handleStatusCodeError;
  final IHandleDatasourceException handleDatasourceException;
  final IAuthManager customAuthManager;
  final IAuthTokenService tokenService;
  final IApiClient argusApiClient;

  @override
  Future<SignUpResponseModel> signUp({
    required String phone,
    required String password,
    required int termsVersion,
    required int privacyPolicyVersion,
  }) async => await handleDatasourceException<SignUpResponseModel>(() async {
    final body = {
      "phone": phone,
      "password": password,
      "terms_version": termsVersion,
      "privacy_policy_version": privacyPolicyVersion,
    };

    final response = await argusApiClient.post(
      route: 'auth/signup',
      requestBody: body,
    );

    if (response.statusCode == 422) {
      throw AlreadyPhoneException();
    }

    if (response.statusCode == 402) {
      throw PaymentRequiredException();
    }

    final exception = await handleStatusCodeError.hasException(
      statusCode: response.statusCode,
    );
    if (exception != null) {
      throw exception;
    }

    final model = SignUpResponseModel.maybeFromMap(response.data);
    if (model != null) {
      return model;
    } else {
      throw Exception();
    }
  }, redirectToLoginOnFail: false);

  @override
  Future<SignInResponseModel> signIn({
    required String phone,
    required String password,
  }) async => await handleDatasourceException<SignInResponseModel>(() async {
    final body = {"phone": phone, "password": password};

    final response = await argusApiClient.post(
      route: 'auth/signin',
      requestBody: body,
    );

    if (response.statusCode == 401 || response.statusCode == 422) {
      throw UnauthorizedException();
    }

    final exception = await handleStatusCodeError.hasException(
      statusCode: response.statusCode,
    );
    if (exception != null) {
      throw exception;
    }

    final model = SignInResponseModel.maybeFromMap(response.data);
    if (model != null) {
      return model;
    } else {
      throw Exception();
    }
  }, redirectToLoginOnFail: false);

  @override
  Future<RefreshTokenResponseModel> refreshToken() async =>
      await tokenService.requestNewAuthToken();

  @override
  Future<void> forgotPassword({required String phone}) async =>
      await handleDatasourceException<void>(() async {
        final body = {"phone": phone};

        final response = await argusApiClient.post(
          route: 'auth/forgot_password',
          requestBody: body,
        );

        final exception = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (exception != null) {
          throw exception;
        }
      }, redirectToLoginOnFail: false);

  @override
  Future<void> resendForgotPasswordCode({
    required String phone,
    required SendCodeTypeEnum sendCodeType,
  }) async => await handleDatasourceException<void>(() async {
    final body = {"phone": phone, "resend_type": sendCodeType.value};

    final response = await argusApiClient.post(
      route: 'auth/resend_forgot_password_code',
      requestBody: body,
    );

    final exception = await handleStatusCodeError.hasException(
      statusCode: response.statusCode,
    );
    if (exception != null) {
      throw exception;
    }
  }, redirectToLoginOnFail: false);

  @override
  Future<void> confirmForgotPassword({
    required String phone,
    required String password,
    required String confirmationCode,
  }) async => await handleDatasourceException<void>(() async {
    final body = {
      "phone": phone,
      "password": password,
      "confirmation_code": confirmationCode,
    };

    final response = await argusApiClient.post(
      route: 'auth/confirm_forgot_password',
      requestBody: body,
    );
    if (response.statusCode == 400) {
      throw InvalidInputException();
    }

    final exception = await handleStatusCodeError.hasException(
      statusCode: response.statusCode,
    );
    if (exception != null) {
      throw exception;
    }
  }, redirectToLoginOnFail: false);

  @override
  Future<void> signOut() async =>
      await handleDatasourceException<void>(() async {
        final response = await argusApiClient.post(
          route: 'auth/signout',
          requestBody: {
            "access_token": customAuthManager.currentAuthenticationToken,
          },
        );

        final exception = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (exception != null) {
          throw exception;
        }
      });
}

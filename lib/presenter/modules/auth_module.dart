import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/modules/i_dependence_module.dart';
import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/i_handle_status_code_error.dart';
import 'package:base_app_clean_arch/data/repository/handle_error/i_handle_error_on_request.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/forgot_password_use_case.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/i_register_user_use_case.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/forgot_password_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../core/services/analytics/i_analytics_service.dart';
import '../../core/services/api_client/api_client_implementation_type.dart';
import '../../core/services/auth_biometrics/auth_biometrics_service.dart';
import '../../core/services/auth_biometrics/i_auth_biometrics_service.dart';
import '../../core/services/auth_token/i_auth_token_service.dart';
import '../../data/datasource/auth_datasource.dart';
import '../../data/datasource/handle_datasource_exception/i_handle_datasource_exception.dart';
import '../../data/datasource/interfaces/i_auth_datasource.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/repository/i_account_repository.dart';
import '../../domain/repository/i_auth_repository.dart';
import '../../domain/usecase/auth/change_password_use_case.dart';
import '../../domain/usecase/auth/i_change_password_use_case.dart';
import '../../domain/usecase/auth/i_forgot_password_use_case.dart';
import '../../domain/usecase/auth/i_resend_forgot_password_code_use_case.dart';
import '../../domain/usecase/auth/i_sign_in_use_case.dart';
import '../../domain/usecase/auth/i_sign_out_use_case.dart';
import '../../domain/usecase/auth/resend_forgot_password_code_use_case.dart';
import '../../domain/usecase/auth/sign_in_use_case.dart';
import '../../domain/usecase/auth/register_user_use_case.dart';
import '../../domain/usecase/auth/sign_out_use_case.dart';
import '../controller/auth/change_password_cubit.dart';
import '../controller/auth/resend_forgot_password_code_cubit.dart';
import '../controller/auth/sign_in_cubit.dart';
import '../controller/auth/sign_out_cubit.dart';
import '../controller/auth/sign_up_cubit.dart';

class AuthModule implements IDependenceModule {
  final getIt = GetIt.instance;

  @override
  void registerDependencies() {
    getIt.registerFactory<IAuthDatasource>(
      () => AuthDatasource(
        handleStatusCodeError: getIt<IHandleStatusCodeError>(),
        handleDatasourceException: getIt<IHandleDatasourceException>(),
        customAuthManager: getIt<IAuthManager>(),
        tokenService: getIt<IAuthTokenService>(),
        argusApiClient: getIt<IApiClient>(
          instanceName: ApiClientImplementationType.argusApiClient.name,
        ),
      ),
    );

    getIt.registerFactory<IAuthRepository>(
      () => AuthRepository(
        handleRequestOrErrors: getIt<IHandleErrorOnRequest>(),
        authDatasource: getIt<IAuthDatasource>(),
      ),
    );

    getIt.registerFactory<IRegisterUserUseCase>(
      () => RegisterUserUseCase(
        authRepository: getIt<IAuthRepository>(),
        accountRepository: getIt<IAccountRepository>(),
        authManager: getIt<IAuthManager>(),
        analyticsService: getIt<IAnalyticsService>(),
      ),
    );

    getIt.registerFactory<IForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(authRepository: getIt<IAuthRepository>()),
    );

    getIt.registerFactory<IResendForgotPasswordCodeUseCase>(
      () => ResendForgotPasswordCodeUseCase(
        authRepository: getIt<IAuthRepository>(),
      ),
    );

    getIt.registerFactory<IChangePasswordUseCase>(
      () => ChangePasswordUseCase(authRepository: getIt<IAuthRepository>()),
    );

    getIt.registerFactory(
      () => SignUpCubit(
        signUpUseCase: getIt<IRegisterUserUseCase>(),
        customAuthManager: getIt<IAuthManager>(),
      ),
    );

    getIt.registerFactory<ISignInUseCase>(
      () => SignInUseCase(
        authRepository: getIt<IAuthRepository>(),
        accountRepository: getIt<IAccountRepository>(),
        authManager: getIt<IAuthManager>(),
        analyticsService: getIt<IAnalyticsService>(),
      ),
    );

    getIt.registerFactory<ISignOutUseCase>(
      () => SignOutUseCase(authRepository: getIt<IAuthRepository>()),
    );

    getIt.registerFactory<IAuthBiometricsService>(
      () => AuthBiometricsService(),
    );

    getIt.registerFactory(
      () => SignInCubit(
        signInUseCase: getIt<ISignInUseCase>(),
        authBiometricsService: getIt<IAuthBiometricsService>(),
        customAuthManager: getIt<IAuthManager>(),
      ),
    );

    getIt.registerFactory(
      () => ForgotPasswordCubit(
        forgotPasswordUseCase: getIt<IForgotPasswordUseCase>(),
        customAuthManager: getIt<IAuthManager>(),
      ),
    );

    getIt.registerFactory(
      () => ResendForgotPasswordCodeCubit(
        resendForgotPasswordCodeUseCase:
            getIt<IResendForgotPasswordCodeUseCase>(),
        customAuthManager: getIt<IAuthManager>(),
      ),
    );

    getIt.registerFactory(
      () => ChangePasswordCubit(
        changePasswordUseCase: getIt<IChangePasswordUseCase>(),
        customAuthManager: getIt<IAuthManager>(),
      ),
    );

    getIt.registerFactory(
      () => SignOutCubit(signOutUseCase: getIt<ISignOutUseCase>()),
    );
  }
}

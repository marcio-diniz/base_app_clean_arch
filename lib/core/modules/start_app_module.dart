import 'package:base_app_clean_arch/core/services/local_storage/i_local_storage_service.dart';
import 'package:base_app_clean_arch/data/datasource/handle_datasource_exception/i_handle_datasource_exception.dart';
import 'package:base_app_clean_arch/domain/usecase/push_notification/i_update_info_push_notification_use_case.dart';
import 'package:base_app_clean_arch/presenter/controller/app_settings/app_settings_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasource/app_settings_datasource.dart';
import '../../data/datasource/handle_status_code_error/i_handle_status_code_error.dart';
import '../../data/datasource/interfaces/i_app_settings_datasource.dart';
import '../../data/repository/app_settings_repository.dart';
import '../../data/repository/handle_error/i_handle_error_on_request.dart';
import '../../data/repository/interfaces/i_account_repository.dart';
import '../../data/repository/interfaces/i_app_settings_repository.dart';
import '../../data/repository/interfaces/i_auth_repository.dart';
import '../../domain/usecase/account/accept_privacy_policy_use_case.dart';
import '../../domain/usecase/account/accept_terms_and_conditions_use_case.dart';
import '../../domain/usecase/account/get_my_account_use_case.dart';
import '../../domain/usecase/account/i_accept_privacy_policy_use_case.dart';
import '../../domain/usecase/account/i_accept_terms_and_conditions_use_case.dart';
import '../../domain/usecase/account/i_get_my_account_use_case.dart';
import '../../domain/usecase/app_settings/get_app_settings_use_case.dart';
import '../../domain/usecase/app_settings/i_get_app_settings_use_case.dart';
import '../../domain/usecase/auth/i_refresh_auth_token_use_case.dart';
import '../../domain/usecase/auth/refresh_auth_token_use_case.dart';
import '../../domain/usecase/push_notification/update_info_push_notification_use_case.dart';
import '../../presenter/controller/account/account_cubit.dart';
import '../auth/i_auth_manager.dart';
import '../services/api_client/api_client_implementation_type.dart';
import '../services/device_info/i_device_info_service.dart';
import '../services/notification/i_notification_service.dart';
import '../services/permission/i_permission_service.dart';
import '../services/start_app/start_app_service.dart';
import '../services/api_client/i_api_client.dart';
import 'i_dependence_module.dart';

class StartAppModule implements IDependenceModule {
  final getIt = GetIt.instance;
  @override
  void registerDependencies() {
    getIt.registerFactory<IAppSettingsDatasource>(
      () => AppSettingsDatasource(
        handleStatusCodeError: getIt<IHandleStatusCodeError>(),
        handleDatasourceException: getIt<IHandleDatasourceException>(),
        apiAuthenticatedClient: getIt<IApiClient>(
          instanceName: ApiClientImplementationType.apiAuthenticatedClient.name,
        ),
      ),
    );

    getIt.registerFactory<IAppSettingsRepository>(
      () => AppSettingsRepository(
        handleRequestOrErrors: getIt<IHandleErrorOnRequest>(),
        appSettingsDatasource: getIt<IAppSettingsDatasource>(),
      ),
    );

    getIt.registerFactory<IGetMyAccountUseCase>(
      () => GetMyAccountUseCase(accountRepository: getIt<IAccountRepository>()),
    );

    getIt.registerFactory<IAcceptTermsAndConditionsUseCase>(
      () => AcceptTermsAndConditionsUseCase(
        accountRepository: getIt<IAccountRepository>(),
      ),
    );

    getIt.registerFactory<IAcceptPrivacyPolicyUseCase>(
      () => AcceptPrivacyPolicyUseCase(
        accountRepository: getIt<IAccountRepository>(),
      ),
    );

    getIt.registerFactory<IGetAppSettingsUseCase>(
      () => GetAppSettingsUseCase(
        appSettingsRepository: getIt<IAppSettingsRepository>(),
      ),
    );

    getIt.registerFactory<IUpdateInfoPushNotificationUseCase>(
      () => UpdateInfoPushNotificationUseCase(
        accountRepository: getIt<IAccountRepository>(),
      ),
    );

    getIt.registerSingleton(
      AccountCubit(
        getMyAccountUseCase: getIt<IGetMyAccountUseCase>(),
        acceptTermsAndConditionsUseCase:
            getIt<IAcceptTermsAndConditionsUseCase>(),
        acceptPrivacyPolicyUseCase: getIt<IAcceptPrivacyPolicyUseCase>(),
      ),
    );

    getIt.registerSingleton(
      AppSettingsCubit(getAppSettingsUseCase: getIt<IGetAppSettingsUseCase>()),
    );

    getIt.registerFactory<IRefreshAuthTokenUseCase>(
      () => RefreshAuthTokenUseCase(
        authRepository: getIt<IAuthRepository>(),
        authManager: getIt<IAuthManager>(),
      ),
    );

    getIt.registerSingleton(
      StartAppService(
        getAccount: getIt<AccountCubit>(),
        getAppSettings: getIt<AppSettingsCubit>(),
        pushNotificationService: getIt<IPushNotificationService>(),
        permissionService: getIt<IPermissionService>(),
        updateInfoPushNotificationUseCase:
            getIt<IUpdateInfoPushNotificationUseCase>(),
        refreshAuthTokenUseCase: getIt<IRefreshAuthTokenUseCase>(),
        deviceInfoService: getIt<IDeviceInfoService>(),
        localStorageService: getIt<ILocalStorageService>(),
      ),
    );
  }
}

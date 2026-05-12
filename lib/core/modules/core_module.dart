import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/environment/environment_manager.dart';
import 'package:base_app_clean_arch/core/modules/i_dependence_module.dart';
import 'package:base_app_clean_arch/core/services/api_client/api_authenticated_client.dart';
import 'package:base_app_clean_arch/core/services/api_client/api_client_implementation_type.dart';
import 'package:base_app_clean_arch/core/services/auth_token/i_auth_token_service.dart';
import 'package:base_app_clean_arch/core/services/launch_url/i_launch_url_service.dart';
import 'package:base_app_clean_arch/core/services/navigation/i_tabs_navigation_observer.dart';
import 'package:base_app_clean_arch/core/services/analytics/analytics_service.dart';
import 'package:base_app_clean_arch/core/services/analytics/i_analytics_service.dart';
import 'package:base_app_clean_arch/core/services/api_client/generic_api_client.dart';
import 'package:base_app_clean_arch/core/services/cache/i_cache_service.dart';
import 'package:base_app_clean_arch/core/services/local_storage/i_local_storage_service.dart';
import 'package:base_app_clean_arch/core/services/local_storage/i_secure_storage_service.dart';
import 'package:base_app_clean_arch/core/services/navigation/i_navigation_service.dart';
import 'package:base_app_clean_arch/core/services/navigation/navigation_service.dart';
import 'package:base_app_clean_arch/core/services/permission/i_permission_service.dart';
import 'package:base_app_clean_arch/core/services/permission/permission_service.dart';
import 'package:base_app_clean_arch/data/datasource/handle_datasource_exception/handle_datasource_exception.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/handle_status_code_error.dart';
import 'package:base_app_clean_arch/data/repository/handle_error/i_handle_error_on_request.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasource/account_cache_datasource.dart';
import '../../data/datasource/account_datasource.dart';
import '../../data/datasource/handle_datasource_exception/i_handle_datasource_exception.dart';
import '../../data/datasource/handle_status_code_error/i_handle_status_code_error.dart';
import '../../data/datasource/interfaces/i_account_cache_datasource.dart';
import '../../data/datasource/interfaces/i_account_datasource.dart';
import '../../data/repository/account_repository.dart';
import '../../data/repository/handle_error/handle_error_on_request.dart';
import '../../data/repository/interfaces/i_account_repository.dart';
import '../auth/auth_manager.dart';
import '../environment/i_environment_manager.dart';
import '../services/analytics/firebase_analytics_client.dart';
import '../services/analytics/i_analytics_client.dart';
import '../services/api_client/argus_api_client.dart';
import '../services/auth_token/auth_token_service.dart';
import '../services/launch_url/launch_url_service.dart';
import '../services/navigation/screen_view_observer.dart';
import '../services/api_client/i_api_client.dart';
import '../services/cache/cache_service.dart';
import '../services/device_info/device_info_service.dart';
import '../services/device_info/i_device_info_service.dart';
import '../services/life_cycle/i_life_cycle_dispatcher.dart';
import '../services/life_cycle/life_cycle_dispatcher.dart';
import '../services/local_storage/local_storage_service.dart';
import '../services/local_storage/secure_storage_service.dart';
import '../services/notification/i_notification_service.dart';
import '../services/notification/notification_service.dart';

class CoreModule implements IDependenceModule {
  final getIt = GetIt.instance;
  @override
  void registerDependencies() {
    getIt.registerSingleton<ILocalStorageService>(LocalStorageService());
    getIt.registerSingleton<ISecureStorageService>(SecureStorageService());
    getIt.registerLazySingleton<IAuthManager>(
      () => AuthManager(secureStorageService: getIt<ISecureStorageService>()),
    );
    getIt.registerLazySingleton<INavigationService>(
      () => NavigationService(customAuthManager: getIt<IAuthManager>()),
    );
    getIt.registerFactory<IHandleStatusCodeError>(
      () => const HandleStatusCodeError(),
    );

    getIt.registerFactory<IHandleErrorOnRequest>(() => HandleErrorOnRequest());
    getIt.registerLazySingleton<IEnvironmentManager>(
      () => EnvironmentManager(customAuthManager: getIt<IAuthManager>()),
    );
    getIt.registerFactory<IApiClient>(
      () => GenericApiClient(environmentManager: getIt<IEnvironmentManager>()),
      instanceName: ApiClientImplementationType.genericApiClient.name,
    );

    getIt.registerFactory<IAuthTokenService>(
      () => AuthTokenService(
        customAuthManager: getIt<IAuthManager>(),
        environmentManager: getIt<IEnvironmentManager>(),
        apiClient: getIt<IApiClient>(
          instanceName: ApiClientImplementationType.genericApiClient.name,
        ),
      ),
    );

    getIt.registerFactory<IApiClient>(
      () => ArgusApiClient(environmentManager: getIt<IEnvironmentManager>()),
      instanceName: ApiClientImplementationType.argusApiClient.name,
    );
    getIt.registerFactory<IApiClient>(
      () => ApiAuthenticatedClient(
        environmentManager: getIt<IEnvironmentManager>(),
        authTokenService: getIt<IAuthTokenService>(),
      ),
      instanceName: ApiClientImplementationType.apiAuthenticatedClient.name,
    );

    getIt.registerFactory<IHandleDatasourceException>(
      () => HandleDatasourceException(
        customAuthManager: getIt<IAuthManager>(),
        navigationService: getIt<INavigationService>(),
        authTokenService: getIt<IAuthTokenService>(),
      ),
    );
    getIt.registerFactory<IDeviceInfoService>(() => DeviceInfoService());
    getIt.registerFactory<IPermissionService>(
      () => PermissionService(deviceInfoService: getIt<DeviceInfoService>()),
    );
    getIt.registerFactory<ICacheService>(
      () => CacheService(localStorageService: getIt<ILocalStorageService>()),
    );
    getIt.registerFactory<ILaunchUrlService>(() => LaunchUrlService());
    getIt.registerFactory<IAnalyticsClient>(() => FirebaseAnalyticsClient());
    getIt.registerFactory<IAnalyticsService>(
      () => AnalyticsService(analyticsClient: getIt<IAnalyticsClient>()),
    );

    final screenViewObserver = ScreenViewObserver();
    getIt.registerSingleton<ScreenViewObserver>(screenViewObserver);
    getIt.registerSingleton<ITabsNavigationObserver>(screenViewObserver);
    getIt.registerSingleton<ILifeCycleDispatcher>(LifeCycleDispatcher());
    getIt.registerFactory<IDeviceInfoService>(() => DeviceInfoService());
    getIt.registerFactory<IAccountDatasource>(
      () => AccountDatasource(
        handleStatusCodeError: getIt<IHandleStatusCodeError>(),
        handleDatasourceException: getIt<IHandleDatasourceException>(),
        apiAuthenticatedClient: getIt<IApiClient>(
          instanceName: ApiClientImplementationType.apiAuthenticatedClient.name,
        ),
      ),
    );

    getIt.registerFactory<IAccountCacheDatasource>(
      () => AccountCacheDatasource(cacheService: getIt<ICacheService>()),
    );

    getIt.registerFactory<IAccountRepository>(
      () => AccountRepository(
        handleRequestOrErrors: getIt<IHandleErrorOnRequest>(),
        accountDatasource: getIt<IAccountDatasource>(),
        accountCacheDatasource: getIt<IAccountCacheDatasource>(),
      ),
    );

    getIt.registerLazySingleton<IPushNotificationService>(
      () => PushNotificationService(
        permissionService: getIt<IPermissionService>(),
      ),
    );
  }
}

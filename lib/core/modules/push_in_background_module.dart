import 'package:base_app_clean_arch/core/services/device_info/device_info_service.dart';
import 'package:base_app_clean_arch/core/services/device_info/i_device_info_service.dart';
import 'package:base_app_clean_arch/core/services/permission/permission_service.dart';
import 'package:get_it/get_it.dart';
import '../services/notification/i_notification_service.dart';
import '../services/notification/notification_service.dart';
import '../services/permission/i_permission_service.dart';
import 'i_dependence_module.dart';

class PushInBackgroundModule implements IDependenceModule {
  final getIt = GetIt.instance;
  @override
  void registerDependencies() {
    getIt.registerFactory<IDeviceInfoService>(() => DeviceInfoService());
    getIt.registerFactory<IPermissionService>(
      () => PermissionService(deviceInfoService: getIt<IDeviceInfoService>()),
    );
    getIt.registerSingleton<IPushNotificationService>(
      PushNotificationService(permissionService: getIt<IPermissionService>()),
    );
  }
}

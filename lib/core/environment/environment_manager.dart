import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/environment/environment_enum.dart';

import 'api_source.dart';
import 'const_environment.dart';
import 'i_environment_manager.dart';

class EnvironmentManager implements IEnvironmentManager {
  EnvironmentManager({required this.customAuthManager});
  final IAuthManager customAuthManager;
  late EnvironmentEnum environment;

  @override
  void initEnvironment({required EnvironmentEnum environment}) {
    this.environment = environment;
  }

  @override
  String getApiRoute() {
    return getValue(key: ApiSource.argus.key);
  }

  @override
  EnvironmentEnum getEnvironment() => environment;

  String getValue({required String key}) {
    final environment =
        ConstEnvironment
            .usersOnlyEnvironment['${customAuthManager.countryCode}${customAuthManager.phoneNumber}'] ??
        this.environment;
    final value = ConstEnvironment.apiConsts[environment]?[key];
    if (value == null) {
      throw Exception("Value not found to key $key");
    }
    return value;
  }
}

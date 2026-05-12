import 'package:base_app_clean_arch/core/environment/environment_enum.dart';
import 'api_source.dart';

class ConstEnvironment {
  static const Map<String, EnvironmentEnum> usersOnlyEnvironment = {
    "+55(11)99999-8888": EnvironmentEnum.staging,
  };

  static Map<EnvironmentEnum, Map<String, String>> apiConsts = {
    EnvironmentEnum.production: {
      ApiSource.argus.key: 'https://api.meuapp.com.br',
    },
    EnvironmentEnum.staging: {ApiSource.argus.key: 'http://192.168.0.000'},
    EnvironmentEnum.testE2E: {ApiSource.argus.key: 'http://fake-api'},
  };
}

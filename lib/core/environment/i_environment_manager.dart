import 'environment_enum.dart';

abstract class IEnvironmentManager {
  void initEnvironment({required EnvironmentEnum environment});
  String getApiRoute();
  EnvironmentEnum getEnvironment();
}

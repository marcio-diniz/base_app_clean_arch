import 'package:base_app_clean_arch/data/model/app_settings_model.dart';

abstract class IAppSettingsDatasource {
  Future<AppSettingsModel> getAppSettings();
}

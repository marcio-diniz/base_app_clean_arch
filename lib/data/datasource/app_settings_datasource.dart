import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/i_handle_status_code_error.dart';

import '../model/app_settings_model.dart';
import 'handle_datasource_exception/i_handle_datasource_exception.dart';
import 'interfaces/i_app_settings_datasource.dart';

class AppSettingsDatasource implements IAppSettingsDatasource {
  const AppSettingsDatasource({
    required this.handleStatusCodeError,
    required this.handleDatasourceException,
    required this.apiAuthenticatedClient,
  });
  final IHandleStatusCodeError handleStatusCodeError;
  final IHandleDatasourceException handleDatasourceException;
  final IApiClient apiAuthenticatedClient;

  @override
  Future<AppSettingsModel> getAppSettings() async =>
      await handleDatasourceException<AppSettingsModel>(() async {
        final response = await apiAuthenticatedClient.get(
          route: 'app_settings/settings',
        );

        final failure = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (failure != null) {
          throw failure;
        }

        final model = AppSettingsModel.maybeFromMap(response.data);
        if (model != null) {
          return model;
        } else {
          throw Exception();
        }
      });
}

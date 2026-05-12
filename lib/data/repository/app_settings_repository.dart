import 'package:base_app_clean_arch/data/datasource/interfaces/i_app_settings_datasource.dart';
import 'package:base_app_clean_arch/data/mapper/app_settings_mapper.dart';
import 'package:base_app_clean_arch/data/repository/handle_error/i_handle_error_on_request.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/entity/app_settings_entity.dart';
import 'interfaces/i_app_settings_repository.dart';

class AppSettingsRepository implements IAppSettingsRepository {
  const AppSettingsRepository({
    required this.appSettingsDatasource,
    required this.handleRequestOrErrors,
  });

  final IAppSettingsDatasource appSettingsDatasource;
  final IHandleErrorOnRequest handleRequestOrErrors;

  @override
  Future<Either<Failure, AppSettingsEntity>> getAppSettings() async =>
      await handleRequestOrErrors<AppSettingsEntity>(() async {
        final result = await appSettingsDatasource.getAppSettings();
        return result.toAppSettingsEntity();
      }, defaultMessageFailure: getAppSettingsFailureMessage);
}

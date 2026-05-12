import 'package:base_app_clean_arch/domain/entity/app_settings_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/i_app_settings_repository.dart';
import 'i_get_app_settings_use_case.dart';

class GetAppSettingsUseCase implements IGetAppSettingsUseCase {
  const GetAppSettingsUseCase({required this.appSettingsRepository});
  final IAppSettingsRepository appSettingsRepository;

  @override
  Future<Either<Failure, AppSettingsEntity>> call() =>
      appSettingsRepository.getAppSettings();
}

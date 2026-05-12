import 'package:base_app_clean_arch/domain/entity/app_settings_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';

abstract class IAppSettingsRepository {
  Future<Either<Failure, AppSettingsEntity>> getAppSettings();
}

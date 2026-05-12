import 'package:base_app_clean_arch/data/mapper/app_settings_mapper.dart';
import 'package:base_app_clean_arch/data/model/app_settings_model.dart';
import 'package:base_app_clean_arch/domain/entity/app_settings_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/factory/app_settings_factory.dart';
import 'test_convert_model_entity.dart';
import 'test_convert_model_map.dart';

void main() {
  group('AppSettingsModel', () {
    final appSettingsFactory = AppSettingsFactory();
    final appSettingsEntity = appSettingsFactory.createEntity();
    final appSettingsModel = appSettingsFactory.createModel();
    final appSettingsMap = appSettingsFactory.createMap();

    testConvertModelEntity<AppSettingsModel, AppSettingsEntity>(
      model: appSettingsModel,
      entity: appSettingsEntity,
      toModel: (entity) => entity.toAppSettingsModel(),
      toEntity: (model) => model.toAppSettingsEntity(),
    );

    testConvertModelMap<AppSettingsModel>(
      model: appSettingsModel,
      map: appSettingsMap,
      fromMap: (map) => AppSettingsModel.fromMap(map),
    );
  });
}

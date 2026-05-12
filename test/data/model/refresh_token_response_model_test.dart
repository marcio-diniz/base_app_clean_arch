import 'package:base_app_clean_arch/data/mapper/refresh_token_response_mapper.dart';
import 'package:base_app_clean_arch/data/model/refresh_token_response_model.dart';
import 'package:base_app_clean_arch/domain/entity/refresh_token_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/factory/refresh_token_response_factory.dart';
import 'test_convert_model_entity.dart';
import 'test_convert_model_map.dart';

void main() {
  group('RefreshTokenResponseModel', () {
    final refreshTokenResponseFactory = RefreshTokenResponseFactory();
    final refreshTokenResponseEntity = refreshTokenResponseFactory
        .createEntity();
    final refreshTokenResponseModel = refreshTokenResponseFactory.createModel();
    final refreshTokenResponseMap = refreshTokenResponseFactory.createMap();

    testConvertModelEntity<
      RefreshTokenResponseModel,
      RefreshTokenResponseEntity
    >(
      model: refreshTokenResponseModel,
      entity: refreshTokenResponseEntity,
      toModel: (entity) => entity.toRefreshTokenResponseModel(),
      toEntity: (model) => model.toRefreshTokenResponseEntity(),
    );

    testConvertModelMap<RefreshTokenResponseModel>(
      model: refreshTokenResponseModel,
      map: refreshTokenResponseMap,
      fromMap: (map) => RefreshTokenResponseModel.fromMap(map),
    );
  });
}

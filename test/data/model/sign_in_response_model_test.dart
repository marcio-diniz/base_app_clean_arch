import 'package:base_app_clean_arch/data/mapper/sign_in_response_mapper.dart';
import 'package:base_app_clean_arch/data/model/sign_in_response_model.dart';
import 'package:base_app_clean_arch/domain/entity/sign_in_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/factory/sign_in_response_factory.dart';
import 'test_convert_model_entity.dart';
import 'test_convert_model_map.dart';

void main() {
  group('SignInResponseModel', () {
    final signInResponseFactory = SignInResponseFactory();
    final signInResponseEntity = signInResponseFactory.createEntity();
    final signInResponseModel = signInResponseFactory.createModel();
    final signInResponseMap = signInResponseFactory.createMap();

    testConvertModelEntity<SignInResponseModel, SignInResponseEntity>(
      model: signInResponseModel,
      entity: signInResponseEntity,
      toModel: (entity) => entity.toSignInResponseModel(),
      toEntity: (model) => model.toSignInResponseEntity(),
    );

    testConvertModelMap<SignInResponseModel>(
      model: signInResponseModel,
      map: signInResponseMap,
      fromMap: (map) => SignInResponseModel.fromMap(map),
    );
  });
}

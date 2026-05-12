import 'package:base_app_clean_arch/data/mapper/sign_up_response_mapper.dart';
import 'package:base_app_clean_arch/data/model/sign_up_response_model.dart';
import 'package:base_app_clean_arch/domain/entity/sign_up_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/factory/sign_up_response_factory.dart';
import 'test_convert_model_entity.dart';
import 'test_convert_model_map.dart';

void main() {
  group('SignUpResponseModel', () {
    final signUpResponseFactory = SignUpResponseFactory();
    final signUpResponseEntity = signUpResponseFactory.createEntity();
    final signUpResponseModel = signUpResponseFactory.createModel();
    final signUpResponseMap = signUpResponseFactory.createMap();

    testConvertModelEntity<SignUpResponseModel, SignUpResponseEntity>(
      model: signUpResponseModel,
      entity: signUpResponseEntity,
      toModel: (entity) => entity.toSignUpResponseModel(),
      toEntity: (model) => model.toSignUpResponseEntity(),
    );

    testConvertModelMap<SignUpResponseModel>(
      model: signUpResponseModel,
      map: signUpResponseMap,
      fromMap: (map) => SignUpResponseModel.fromMap(map),
    );
  });
}

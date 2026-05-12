import 'package:base_app_clean_arch/data/model/model.dart';
import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

void testConvertModelEntity<T extends Model, E extends Entity>({
  required T model,
  required E entity,
  required T Function(E) toModel,
  required E Function(T) toEntity,
}) {
  final String instanceName = model.runtimeType.toString();

  group('convert model/entity $instanceName', () {
    test('should convert from model to entity and back to model', () {
      final entityFromModel = toEntity(model);
      final modelFromEntity = toModel(entityFromModel);
      expect(modelFromEntity, equals(model));
    });

    test('should convert from entity to model and back to entity', () {
      final modelFromEntity = toModel(entity);
      final entityFromModel = toEntity(modelFromEntity);
      expect(entityFromModel, equals(entity));
    });
  });
}

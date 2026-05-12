import 'package:base_app_clean_arch/data/model/model.dart';
import 'package:flutter_test/flutter_test.dart';

void testConvertModelMap<T extends Model>({
  required T model,
  required Map<String, dynamic> map,
  required T Function(Map<String, dynamic> map) fromMap,
}) {
  final String instanceName = model.runtimeType.toString();

  group('convert model/map $instanceName', () {
    test('should convert from map to model and back to map', () {
      final modelFromMap = fromMap(map);
      final mapFromModel = modelFromMap.toMap();
      expect(mapFromModel, equals(map));
    });

    test('should convert model to map and back to model', () {
      final mapFromModel = model.toMap();
      final modelFromMap = fromMap(mapFromModel);
      expect(modelFromMap, equals(model));
    });
  });
}

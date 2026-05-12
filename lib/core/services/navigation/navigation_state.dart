import 'package:go_router/go_router.dart';

import '../../../domain/entity/entity.dart';

extension NavigationState on GoRouterState {
  String getString(String key) {
    final response = uri.queryParameters[key];
    if (response == null) {
      throw Exception('Param $key not found');
    }
    return response;
  }

  String? tryGetString(String key) => uri.queryParameters[key];

  T? getParameterByType<T extends Object>(String key) {
    final result = uri.queryParameters[key];
    if (result == null) return null;
    switch (T) {
      case const (String):
        return result as T;
      case const (int):
        return int.tryParse(result) as T?;
      case const (double):
        return double.tryParse(result) as T?;
      case const (bool):
        return bool.tryParse(result) as T?;
      default:
        return null;
    }
  }

  T? getEntity<T extends Entity>(String key) {
    if (extra is Map<String, dynamic>) {
      final map = extra as Map<String, dynamic>;
      final entity = map[key];

      if (entity is T) {
        return entity;
      }
    }

    return null;
  }

  List<T>? getEntityList<T extends Entity>(String key) {
    if (extra is Map<String, dynamic>) {
      final map = extra as Map<String, dynamic>;
      final entityList = map[key];

      if (entityList is List) {
        if (entityList.isNotEmpty && entityList.every((item) => item is T)) {
          return entityList.cast<T>();
        }
      }
    }

    return null;
  }
}

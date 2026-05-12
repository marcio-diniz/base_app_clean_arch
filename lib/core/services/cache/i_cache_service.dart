import '../../../data/model/model.dart';

abstract class ICacheService {
  Future<void> setModel({
    required String key,
    required Model model,
  });

  Future<void> setListOfModel({
    required String key,
    required List<Model> listModels,
  });

  Future<T?> getModel<T extends Model>({
    required String key,
    required T? Function(dynamic) maybeFromMap,
  });

  Future<List<T>?> getListOfModel<T extends Model>({
    required String key,
    required T? Function(dynamic) maybeFromMap,
  });

  Future<bool> cacheIsExpired({
    required String key,
    required Duration expirationTime,
  });
}

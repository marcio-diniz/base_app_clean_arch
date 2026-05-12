import 'dart:convert';
import 'package:base_app_clean_arch/core/services/cache/i_cache_service.dart';
import 'package:base_app_clean_arch/core/services/local_storage/i_local_storage_service.dart';
import 'package:base_app_clean_arch/data/model/model.dart';

class CacheService implements ICacheService {
  const CacheService({required this.localStorageService});

  final ILocalStorageService localStorageService;

  String _dateTimeKey({required String key}) => '${key}_datetime';

  @override
  Future<void> setModel({required String key, required Model model}) async {
    final map = model.toMap();
    final dateTime = DateTime.now();

    await localStorageService.setString(key: key, data: jsonEncode(map));

    await localStorageService.setString(
      key: _dateTimeKey(key: key),
      data: dateTime.toIso8601String(),
    );
  }

  @override
  Future<void> setListOfModel({
    required String key,
    required List<Model> listModels,
  }) async {
    final list = listModels.map((e) => e.toMap()).toList();
    final dateTime = DateTime.now();

    await localStorageService.setString(key: key, data: jsonEncode(list));
    await localStorageService.setString(
      key: _dateTimeKey(key: key),
      data: dateTime.toIso8601String(),
    );
  }

  @override
  Future<T?> getModel<T extends Model>({
    required String key,
    required T? Function(dynamic) maybeFromMap,
  }) async {
    final result = await localStorageService.getString(key: key);
    if (result == null) {
      return null;
    }
    final map = jsonDecode(result);
    return maybeFromMap(map);
  }

  @override
  Future<List<T>?> getListOfModel<T extends Model>({
    required String key,
    required T? Function(dynamic) maybeFromMap,
  }) async {
    final result = await localStorageService.getString(key: key);
    if (result == null) {
      return null;
    }

    final map = jsonDecode(result);
    final list = <T>[];
    for (final data in map) {
      final model = maybeFromMap(data);
      if (model != null) {
        list.add(model);
      }
    }
    return list;
  }

  @override
  Future<bool> cacheIsExpired({
    required String key,
    required Duration expirationTime,
  }) async {
    final dateTime = DateTime.tryParse(
      await localStorageService.getString(key: _dateTimeKey(key: key)) ?? '',
    );
    if (dateTime == null) {
      return true;
    }
    final now = DateTime.now();
    final diference = now.difference(dateTime);
    if (diference > expirationTime) {
      return true;
    }
    return false;
  }
}

import 'package:base_app_clean_arch/core/services/local_storage/i_secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService implements ISecureStorageService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> getString({required String key}) async {
    try {
      return await secureStorage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setString({required String key, required String data}) async {
    await secureStorage.write(key: key, value: data);
  }

  @override
  Future<int?> getInt({required String key}) async {
    try {
      final response = await secureStorage.read(key: key);
      if (response == null) return null;
      return int.tryParse(response);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setInt({required String key, required int data}) async {
    await secureStorage.write(key: key, value: data.toString());
  }

  @override
  Future<bool?> getBool({required String key}) async {
    try {
      final response = await secureStorage.read(key: key);
      if (response == null) return null;
      return response == 'true';
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setBool({required String key, required bool data}) async {
    await secureStorage.write(key: key, value: data.toString());
  }

  @override
  Future<void> clearValue({required String key}) async {
    await secureStorage.delete(key: key);
  }
}

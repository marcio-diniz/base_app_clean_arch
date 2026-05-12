abstract class ISecureStorageService {
  Future<String?> getString({required String key});

  Future<void> setString({required String key, required String data});

  Future<int?> getInt({required String key});

  Future<void> setInt({required String key, required int data});

  Future<bool?> getBool({required String key});

  Future<void> setBool({required String key, required bool data});

  Future<void> clearValue({required String key});
}

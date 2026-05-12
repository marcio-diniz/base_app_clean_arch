abstract class ILocalStorageService {
  Future<bool> lastNotificationPermission();

  Future<void> setLastNotificationPermission(bool value);

  Future<bool?> hasEmergencyContact();

  Future<void> setHasEmergencyContact({required bool value});

  Future<String?> getString({required String key});

  Future<void> setString({required String key, required String data});

  Future<int?> getInt({required String key});

  Future<void> setInt({required String key, required int data});

  Future<void> clearAll();

  Future<void> clearValue({required String key});
}

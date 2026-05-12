import 'package:base_app_clean_arch/core/services/local_storage/i_local_storage_service.dart';
import 'package:base_app_clean_arch/core/services/local_storage/local_storage_key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService implements ILocalStorageService {
  SharedPreferences? prefs;

  @override
  Future<bool> lastNotificationPermission() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getBool(LocalStorageKeyConstants.hasNotificationPermission) ??
        false;
  }

  @override
  Future<void> setLastNotificationPermission(bool value) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setBool(
      LocalStorageKeyConstants.hasNotificationPermission,
      value,
    );
  }

  @override
  Future<void> setString({required String key, required String data}) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setString(key, data);
  }

  @override
  Future<String?> getString({required String key}) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getString(key);
  }

  @override
  Future<void> setInt({required String key, required int data}) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setInt(key, data);
  }

  @override
  Future<int?> getInt({required String key}) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getInt(key);
  }

  @override
  Future<void> clearAll() async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.clear();
  }

  @override
  Future<void> clearValue({required String key}) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.remove(key);
  }

  @override
  Future<bool?> hasEmergencyContact() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getBool(
      LocalStorageKeyConstants.haveAskedSaveEmergencyContact,
    );
  }

  @override
  Future<void> setHasEmergencyContact({required bool value}) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setBool(
      LocalStorageKeyConstants.haveAskedSaveEmergencyContact,
      value,
    );
  }
}

abstract class IDeviceInfoService {
  Future<int> getAppVersionNumber();

  Future<String> getAppVersionName();

  Future<int?> getVersionAndroidSdk();
}

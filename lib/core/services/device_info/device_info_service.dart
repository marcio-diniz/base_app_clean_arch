import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'i_device_info_service.dart';

class DeviceInfoService implements IDeviceInfoService {
  @override
  Future<int> getAppVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return int.parse(packageInfo.buildNumber);
  }

  @override
  Future<String> getAppVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<int?> getVersionAndroidSdk() async {
    if (!Platform.isAndroid) {
      return null;
    }

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  }
}

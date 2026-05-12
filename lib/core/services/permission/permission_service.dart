import 'dart:io';
import 'package:base_app_clean_arch/core/services/device_info/i_device_info_service.dart';
import 'package:base_app_clean_arch/core/services/permission/i_permission_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService implements IPermissionService {
  const PermissionService({required IDeviceInfoService deviceInfoService})
    : _deviceInfoService = deviceInfoService;
  final IDeviceInfoService _deviceInfoService;

  @override
  Future<bool> getPushPermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.requestNotificationsPermission() ??
          false;
    } else {
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
  }

  @override
  Future<bool> getStorageWritePermission() async {
    if (Platform.isAndroid) {
      final versionAndroidSdk = await _deviceInfoService.getVersionAndroidSdk();
      if ((versionAndroidSdk ?? 0) > 29) {
        return true;
      }
    }
    final response = await Permission.storage.request();
    return response.isGranted;
  }

  @override
  Future<bool> getContactsWritePermission() async {
    final response = await Permission.contacts.request();
    return response.isGranted;
  }
}

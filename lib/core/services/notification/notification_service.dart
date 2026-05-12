import 'dart:convert';
import 'dart:io';
import 'package:base_app_clean_arch/core/services/life_cycle/i_life_cycle_observer.dart';
import 'package:base_app_clean_arch/core/services/notification/i_notification_service.dart';
import 'package:base_app_clean_arch/core/services/permission/i_permission_service.dart';
import 'package:base_app_clean_arch/domain/enums/push_priority_enum.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../domain/enums/push_notification_type_enum.dart';

class PushNotificationService implements IPushNotificationService {
  PushNotificationService({
    required IPermissionService permissionService,
    ILifeCycleObserver? registerAppOpened,
  }) : _permissionService = permissionService,
       _registerAppOpened = registerAppOpened;

  final IPermissionService _permissionService;
  final ILifeCycleObserver? _registerAppOpened;

  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Function(String route, {Map<String, String>? queryParameters})? _pushNamed;
  Map<String, dynamic>? _initialMessageData;

  static const AndroidNotificationChannel _highImportantChannel =
      AndroidNotificationChannel(
        'high-important-channel',
        'Mensagens',
        importance: Importance.max,
        ledColor: Colors.red,
        enableVibration: true,
        playSound: true,
      );

  static const AndroidNotificationChannel _lowImportantChannel =
      AndroidNotificationChannel(
        'low-important-channel',
        'Events Default',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
      );

  static final Map<String, AndroidNotificationChannel> _channels = {
    'high-important-channel': _highImportantChannel,
    'low-important-channel': _lowImportantChannel,
  };

  AndroidNotificationChannel _getChannelById(String? channelId) {
    if (channelId == null) return _highImportantChannel;
    return _channels[channelId] ?? _highImportantChannel;
  }

  @override
  Future<void> initialize() async {
    final permission = await _permissionService.getPushPermission();
    if (!permission) return;
    await _createChannels();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      final String? payload =
          notificationAppLaunchDetails?.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(payload);
        _initialMessageData = data;
      }
    }

    const initializationSettingsAndroid = AndroidInitializationSettings(
      'ic_launcher',
    );

    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload == null) return;
        _navigateFromPayload(jsonDecode(details.payload!));
      },
    );

    await Future.delayed(const Duration(seconds: 1));

    await _firebaseMessaging.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _registerAppOpened?.onResume();
      await _showPushNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _navigateFromPayload(message.data);
    });
  }

  @override
  Future<String?> getFCMToken() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return null;
    }
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }

  @override
  Future<void> onStartedApp(
    Function(String route, {Map<String, String>? queryParameters}) pushNamed,
  ) async {
    _pushNamed = pushNamed;
    final message = await FirebaseMessaging.instance.getInitialMessage();
    final data = message?.data ?? _initialMessageData;
    _navigateFromPayload(data);
    _initialMessageData = null;
  }

  void _navigateFromPayload(Map<String, dynamic>? payload) {
    if (payload == null) return;
    if (_pushNamed == null) return;

    final pushType = PushNotificationTypeEnum.fromValue(
      payload['notification_type'],
    );
    final String? entityId = payload['entity_id'];

    switch (pushType) {
      case PushNotificationTypeEnum.newDriver:
        if (entityId == null || entityId.isEmpty) return;
        _pushNamed!(
          'EventDriverDetection',
          queryParameters: {'eventId': entityId},
        );
        return;

      case PushNotificationTypeEnum.snapshotImage:
        final map = jsonDecode(entityId ?? '{}') as Map<String, dynamic>?;
        final vehicleId = map?['vehicle_id'];
        final snapshotId = map?['event_id'];
        if (vehicleId == null ||
            vehicleId.isEmpty ||
            snapshotId == null ||
            snapshotId.isEmpty) {
          _pushNamed!('Snapshot');
          return;
        }
        _pushNamed!(
          'SnapshotViewPage',
          queryParameters: {'snapshotId': snapshotId, 'vehicleId': vehicleId},
        );
        return;

      case PushNotificationTypeEnum.panicButton:
        if (entityId == null || entityId.isEmpty) return;
        _pushNamed!(
          'EventDefault',
          queryParameters: {
            'eventId': entityId,
            'eventName': 'Botão do Pânico',
          },
        );
        return;

      case PushNotificationTypeEnum.blockStatus:
        if (entityId == null || entityId.isEmpty) return;
        _pushNamed!(
          'EventBlock',
          queryParameters: {
            'eventId': entityId,
            'isBlock':
                ((payload['title']?.toLowerCase().contains('bloqueado') ??
                            false) ||
                        (payload['title']?.toLowerCase().contains('bloqueio') ??
                            false))
                    .toString(),
          },
        );
        return;

      case PushNotificationTypeEnum.blockVehicleRequest:
        return;

      case PushNotificationTypeEnum.fileUploaded:
        _pushNamed!('history');
        return;
      case PushNotificationTypeEnum.ignitionInGuardianMode:
        if (entityId == null || entityId.isEmpty) return;
        _pushNamed!(
          'IgnitionOnInGuardianModeEventPage',
          queryParameters: {'eventId': entityId},
        );
        return;
      case PushNotificationTypeEnum.route:
        if (entityId == null || entityId.isEmpty) return;
        _pushNamed!(entityId);
        return;
      default:
        return;
    }
  }

  Future<void> _createChannels() async {
    if (!Platform.isAndroid) return;

    final androidPlatformChannelSpecifics = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlatformChannelSpecifics != null) {
      await androidPlatformChannelSpecifics.createNotificationChannel(
        _lowImportantChannel,
      );
      await androidPlatformChannelSpecifics.createNotificationChannel(
        _highImportantChannel,
      );
    }
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  @override
  Future<void> showBackgroundNotification(RemoteMessage message) async {
    return _showPushNotification(message);
  }

  Future<void> _showPushNotification(RemoteMessage message) async {
    final data = message.data;
    final priority = PushPriorityEnum.fromValue(data['push_priority']);

    NotificationDetails notificationDetails = priority == PushPriorityEnum.low
        ? await _generateLowPriorityNotificationDetails(data: data)
        : await _generateHighPriorityNotificationDetails(data: data);

    await _flutterLocalNotificationsPlugin.show(
      id: message.hashCode,
      title: data['title'],
      body: data['body'],
      notificationDetails: notificationDetails,
      payload: jsonEncode(data),
    );
  }

  Future<NotificationDetails> _generateLowPriorityNotificationDetails({
    required Map<String, dynamic> data,
  }) async {
    final channel = _getChannelById(data['channel_id']);
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: 'ic_launcher',
        importance: Importance.max,
        priority: Priority.low,
      ),
      iOS: const DarwinNotificationDetails(
        interruptionLevel: InterruptionLevel.passive,
        presentSound: false,
      ),
    );
  }

  Future<NotificationDetails> _generateHighPriorityNotificationDetails({
    required Map<String, dynamic> data,
  }) async {
    final channel = _getChannelById(data['channel_id']);
    final imageUrl = data['image'];
    FilePathAndroidBitmap? androidBitmap;
    List<DarwinNotificationAttachment> attachments = [];

    if (imageUrl != null) {
      final filePath = await _downloadAndSaveFile(imageUrl, 'image.jpg');
      androidBitmap = FilePathAndroidBitmap(filePath);
      attachments.add(DarwinNotificationAttachment(filePath));
    }

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: 'ic_launcher',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: androidBitmap,
      ),
      iOS: DarwinNotificationDetails(
        interruptionLevel: InterruptionLevel.timeSensitive,
        attachments: attachments,
      ),
    );
  }
}

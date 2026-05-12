import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IPushNotificationService {
  Future<void> initialize();

  Future<String?> getFCMToken();

  Future<void> onStartedApp(
    Function(
      String route, {
      Map<String, String>? queryParameters,
    }) pushNamed,
  );

  Future<void> showBackgroundNotification(RemoteMessage message);
}

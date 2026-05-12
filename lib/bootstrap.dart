import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/environment/environment_enum.dart';
import 'package:base_app_clean_arch/core/environment/environment_test_e2e_dependencies.dart'
    show EnvironmentTestE2EDependencies;
import 'package:base_app_clean_arch/core/environment/i_environment_manager.dart';
import 'package:base_app_clean_arch/core/modules/push_in_background_module.dart';
import 'package:base_app_clean_arch/core/services/analytics/i_analytics_service.dart';
import 'package:base_app_clean_arch/core/services/auth_token/i_auth_token_service.dart';
import 'package:base_app_clean_arch/core/services/notification/i_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'core/modules/inject_dependence_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
  await Firebase.initializeApp();
  await setupDependenciesForBackground();
  GetIt.instance<IPushNotificationService>().showBackgroundNotification(
    message,
  );
}

Future<void> setupDependenciesForBackground() async {
  final sl = GetIt.instance;

  if (!sl.isRegistered<IPushNotificationService>()) {
    PushInBackgroundModule().registerDependencies();
  }
}

class Bootstrap {
  static Future<void> initializeApp({
    required EnvironmentEnum environment,
    EnvironmentTestE2EDependencies? environmentTestE2EDependencies,
  }) async {
    InjectDependenceService().registerDependencies(
      overrideCoreRegister:
          environmentTestE2EDependencies?.overrideCoreRegister,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final getIt = GetIt.instance;
    getIt<IEnvironmentManager>().initEnvironment(environment: environment);
    await getIt<IPushNotificationService>().initialize();
    final authManager = getIt<IAuthManager>();
    final authTokenService = getIt<IAuthTokenService>();
    await authManager.initialize();
    await authTokenService.ensureValidToken();
    await getIt<IAnalyticsService>().setUserId(id: authManager.currentUserUid);

    if (environment != EnvironmentEnum.testE2E) {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    }
  }
}

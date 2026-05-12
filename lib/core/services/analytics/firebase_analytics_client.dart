import 'package:base_app_clean_arch/core/services/analytics/i_analytics_client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsClient implements IAnalyticsClient {
  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  @override
  Future<void> setUserId({required String? id}) async {
    await FirebaseAnalytics.instance.setUserId(id: id);
  }
}

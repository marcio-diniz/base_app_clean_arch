import 'dart:math';

import 'package:base_app_clean_arch/core/services/analytics/i_analytics_service.dart';
import '../../../domain/enums/navigation_type_enum.dart';
import 'i_analytics_client.dart';

const kMaxEventNameLength = 40;
const kMaxParameterLength = 100;

class AnalyticsService implements IAnalyticsService {
  const AnalyticsService({required this.analyticsClient});
  final IAnalyticsClient analyticsClient;

  @override
  Future<void> logScreenPage({
    required String screenName,
    required String? lastScreenName,
    required NavigationTypeEnum navigationType,
  }) async {
    const eventName = 'screen_view';

    final params = <String, Object>{
      'screen_name': screenName,
      'last_screen_name': lastScreenName ?? '',
      'navigation_type': navigationType.value,
    };

    _logFirebaseEvent(eventName: eventName, parameters: params);
  }

  @override
  Future<void> setUserId({required String? id}) async {
    await analyticsClient.setUserId(id: id);
  }

  void _logFirebaseEvent({
    required String eventName,
    Map<String?, Object>? parameters,
  }) {
    assert(eventName.length <= kMaxEventNameLength);

    parameters ??= {};
    parameters.removeWhere((k, v) => k == null);
    final params = parameters.map((k, v) => MapEntry(k!, v));
    for (final entry in params.entries) {
      if (entry.value is! num) {
        var valStr = entry.value.toString();
        if (valStr.length > kMaxParameterLength) {
          valStr = valStr.substring(0, min(valStr.length, kMaxParameterLength));
        }
        params[entry.key] = valStr;
      }
    }

    analyticsClient.logEvent(name: eventName, parameters: params);
  }
}

abstract class IAnalyticsClient {
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  });

  Future<void> setUserId({required String? id});
}

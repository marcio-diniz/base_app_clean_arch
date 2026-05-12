import '../../../domain/enums/navigation_type_enum.dart';

abstract class IAnalyticsService {
  Future<void> logScreenPage({
    required String screenName,
    required String? lastScreenName,
    required NavigationTypeEnum navigationType,
  });

  Future<void> setUserId({required String? id});
}

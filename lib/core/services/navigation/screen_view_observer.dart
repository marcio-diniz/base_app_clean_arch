import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/enums/navigation_type_enum.dart';
import '../analytics/i_analytics_service.dart';
import 'i_tabs_navigation_observer.dart';

class ScreenViewObserver extends NavigatorObserver
    implements ITabsNavigationObserver {
  final _analyticsService = GetIt.instance<IAnalyticsService>();
  String _lastTabName = 'Home';

  void _sendScreenView({
    required String? screenName,
    required String? lastScreenName,
    required NavigationTypeEnum navigationType,
  }) {
    if (screenName != null && screenName != '') {
      _analyticsService.logScreenPage(
        screenName: overrideScreenName(screenName) ?? '',
        lastScreenName: overrideScreenName(lastScreenName),
        navigationType: navigationType,
      );
    }
  }

  String? overrideScreenName(String? screenName) {
    if (screenName == 'HomePage' || screenName == '_initialize') {
      return _lastTabName;
    }
    return screenName;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _sendScreenView(
      screenName: route.settings.name,
      lastScreenName: previousRoute?.settings.name,
      navigationType: NavigationTypeEnum.push,
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _sendScreenView(
      screenName: newRoute?.settings.name,
      lastScreenName: oldRoute?.settings.name,
      navigationType: NavigationTypeEnum.replacement,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _sendScreenView(
      screenName: previousRoute?.settings.name,
      lastScreenName: route.settings.name,
      navigationType: NavigationTypeEnum.pop,
    );
  }

  @override
  void navigationTab({
    required String tabName,
    required String lastTabName,
  }) {
    _lastTabName = tabName;
    _sendScreenView(
      screenName: tabName,
      lastScreenName: lastTabName,
      navigationType: NavigationTypeEnum.changedTab,
    );
  }
}

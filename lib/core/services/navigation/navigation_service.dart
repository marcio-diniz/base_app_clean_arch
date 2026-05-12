import 'package:base_app_clean_arch/core/error/exceptions.dart';
import 'package:base_app_clean_arch/core/services/navigation/navigation_state.dart';
import 'package:base_app_clean_arch/my_app.dart';
import 'package:base_app_clean_arch/presenter/pages/auth/auth_change_password_widget.dart';
import 'package:base_app_clean_arch/presenter/pages/auth/auth_create_widget.dart';
import 'package:base_app_clean_arch/presenter/pages/auth/auth_forgot_password_widget.dart';
import 'package:base_app_clean_arch/presenter/pages/auth/auth_login_widget.dart';
import 'package:base_app_clean_arch/presenter/pages/docs/privacy_policy_page_widget.dart';
import 'package:base_app_clean_arch/presenter/pages/docs/terms_and_conditions_page_widget.dart';
import 'package:base_app_clean_arch/presenter/pages/exceptions_page/update_app_page_widget.dart'
    show UpdateAppPageWidget;
import 'package:base_app_clean_arch/presenter/pages/support/support_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../auth/i_auth_manager.dart';
import 'custom_route.dart';
import 'i_navigation_service.dart';
import 'screen_view_observer.dart';

class NavigationService implements INavigationService {
  NavigationService({required this.customAuthManager});
  final IAuthManager customAuthManager;

  final Map<String, CustomRoute> _routeMap = {};

  late GoRouter _router;

  @override
  GoRouter createRouter() {
    _routes().forEach((route) {
      _routeMap[route.name] = route;
    });

    _router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      errorBuilder: _buildInitialPage,
      routes: [..._routes().map((r) => r.toRoute())],
      observers: [ScreenViewObserver()],
    );
    return _router;
  }

  CustomRoute routeByName({required String name}) {
    final route = _routeMap[name];
    if (route == null) {
      throw NotFoundException();
    }
    return route;
  }

  @override
  void goNamed({
    required String name,
    Map<String, String>? pathParameters,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? extra,
  }) {
    if (routeByName(name: name).requireAuth && !customAuthManager.loggedIn) {
      return _router.goNamed('auth_Login');
    }
    final combinedExtra = <String, dynamic>{if (extra != null) ...extra};

    return _router.goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: combinedExtra,
    );
  }

  @override
  Future<T?> pushNamed<T extends Object?>({
    required String name,
    required BuildContext context,
    Map<String, String>? pathParameters,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? extra,
  }) async {
    if (routeByName(name: name).requireAuth && !customAuthManager.loggedIn) {
      _router.goNamed('auth_Login');
      return null;
    }

    final combinedExtra = <String, dynamic>{if (extra != null) ...extra};
    return context.pushNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: combinedExtra,
    );
  }

  @override
  void pushReplacementNamed({
    required String name,
    required BuildContext context,
    Map<String, String>? pathParameters,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? extra,
  }) {
    if (routeByName(name: name).requireAuth && !customAuthManager.loggedIn) {
      return _router.goNamed('auth_Login');
    }

    final combinedExtra = <String, dynamic>{if (extra != null) ...extra};

    return context.pushReplacementNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: combinedExtra,
    );
  }

  @override
  void pop<T extends Object?>({required BuildContext context, T? result}) {
    return context.pop(result);
  }

  @override
  void safePop({required BuildContext context}) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  Widget _buildInitialPage(BuildContext context, GoRouterState state) {
    return customAuthManager.loggedIn
        ? const NavBarPage()
        : const AuthLoginWidget();
  }

  List<CustomRoute> _routes() => [
    CustomRoute(name: '_initialize', path: '/', builder: _buildInitialPage),
    CustomRoute(
      name: 'HomePage',
      path: '/homePage',
      builder: (context, state) => const NavBarPage(),
    ),
    CustomRoute(
      name: 'auth_Create',
      path: '/authCreate',
      requireAuth: false,
      builder: (context, state) => const AuthCreateWidget(),
    ),
    CustomRoute(
      name: 'auth_Login',
      path: '/authLogin',
      requireAuth: false,
      builder: (context, state) => const AuthLoginWidget(),
    ),
    CustomRoute(
      name: 'auth_ChangePassword',
      path: '/authChangePassword',
      requireAuth: false,
      builder: (context, state) => const AuthChangePasswordWidget(),
    ),
    CustomRoute(
      name: 'auth_ForgotPassword',
      path: '/authForgotPassword',
      requireAuth: false,
      builder: (context, state) => const AuthForgotPasswordWidget(),
    ),

    CustomRoute(
      name: 'UpdateAppPage',
      path: '/updateAppPage',
      builder: (context, state) => const UpdateAppPageWidget(),
    ),
    CustomRoute(
      name: 'TermsAndConditionsPage',
      path: '/termsAndConditionsPage',
      builder: (context, state) => TermsAndConditionsPageWidget(
        readOnly: state.getParameterByType<bool>('readOnly'),
      ),
    ),
    CustomRoute(
      name: 'PrivacyPolicyPage',
      path: '/privacyPolicyPage',
      builder: (context, state) => PrivacyPolicyPageWidget(
        readOnly: state.getParameterByType<bool>('readOnly'),
      ),
    ),
    CustomRoute(
      name: 'SupportPage',
      path: '/supportPage',
      builder: (context, state) => const SupportPageWidget(),
    ),
  ];
}

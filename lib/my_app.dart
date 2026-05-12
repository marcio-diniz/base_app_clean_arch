import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'core/design_system/components/custom_snack_bar.dart';
import 'core/widget/life_cycle_manager.dart';
import 'core/services/life_cycle/i_life_cycle_dispatcher.dart';
import 'core/services/navigation/i_navigation_service.dart';
import 'core/services/notification/i_notification_service.dart';
import 'core/services/start_app/start_app_service.dart';
import 'presenter/controller/simple_state.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  late GoRouter _router;

  final _lifeCycleDispatcher = GetIt.instance<ILifeCycleDispatcher>();

  @override
  void initState() {
    super.initState();
    _router = GetIt.instance<INavigationService>().createRouter();
  }

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      lifeCycleDispatcher: _lifeCycleDispatcher,
      child: MaterialApp.router(
        title: 'base_app_clean_arch',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: const [Locale('pt')],
        theme: ThemeData(brightness: Brightness.light, useMaterial3: false),
        routerConfig: _router,
      ),
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final _startAppCubit = GetIt.instance<StartAppService>();
  final _pushNotificationService = GetIt.instance<IPushNotificationService>();
  final _navigationService = GetIt.instance<INavigationService>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _startAppCubit.init(context);
      _pushNotificationService.onStartedApp(
        (route, {Map<String, String>? queryParameters}) =>
            _navigationService.pushNamed(
              name: route,
              context: context,
              queryParameters: queryParameters,
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StartAppService, SimpleState<void, StartAppEnum>>(
      bloc: _startAppCubit,
      listener: (context, state) async {
        switch (state.status) {
          case StartAppEnum.redirectToLogin:
            _navigationService.goNamed(name: 'auth_Login');
            break;
          case StartAppEnum.failureGetAccount:
          case StartAppEnum.failureGetAppSettings:
            return CustomSnackBar.showError(
              context: context,
              title: state.messageFailure ?? '',
            );

          case StartAppEnum.redirectToForceUpdate:
            _navigationService.pushReplacementNamed(
              name: 'UpdateAppPage',
              context: context,
            );
            break;

          case StartAppEnum.redirectToTerms:
            await _navigationService.pushNamed(
              name: 'TermsAndConditionsPage',
              context: context,
              queryParameters: {'readOnly': false.toString()},
            );
            _startAppCubit.init(context);
            break;

          case StartAppEnum.redirectToPrivacyPolicy:
            await _navigationService.pushNamed(
              name: 'PrivacyPolicyPage',
              context: context,
              queryParameters: {'readOnly': false.toString()},
            );
            _startAppCubit.init(context);
            break;

          case StartAppEnum.complete:
          case StartAppEnum.initial:
            break;
        }
      },
      child: Scaffold(body: Container()),
    );
  }
}

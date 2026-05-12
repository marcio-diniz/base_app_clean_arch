import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const kTransitionInfoKey = '__transition_info__';

class CustomRoute {
  const CustomRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = true,
    this.asyncParams = const {},
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, GoRouterState) builder;

  GoRoute toRoute() => GoRoute(
    name: name,
    path: path,
    pageBuilder: (context, state) {
      final child = builder(context, state);
      return MaterialPage(key: state.pageKey, child: child, name: name);
    },
  );
}

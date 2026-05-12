import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class INavigationService {
  GoRouter createRouter();

  void goNamed({
    required String name,
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? extra,
  });

  Future<T?> pushNamed<T extends Object?>({
    required String name,
    required BuildContext context,
    Map<String, String>? pathParameters,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? extra,
  });

  void pushReplacementNamed({
    required String name,
    required BuildContext context,
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? extra,
  });

  void pop<T extends Object?>({required BuildContext context, T? result});

  void safePop({required BuildContext context});
}

import 'dart:io';

import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/services/auth_token/i_auth_token_service.dart';
import 'package:base_app_clean_arch/core/services/navigation/i_navigation_service.dart';

import '../../../core/error/exceptions.dart';
import 'i_handle_datasource_exception.dart';

class HandleDatasourceException implements IHandleDatasourceException {
  const HandleDatasourceException({
    required this.authTokenService,
    required this.customAuthManager,
    required this.navigationService,
  });
  final IAuthTokenService authTokenService;
  final IAuthManager customAuthManager;
  final INavigationService navigationService;

  @override
  Future<T> call<T>(
    Future<T> Function() request, {
    bool redirectToLoginOnFail = true,
  }) async {
    try {
      return await request();
    } on UnauthorizedException {
      if (redirectToLoginOnFail) {
        await customAuthManager.signOut();
        navigationService.goNamed(name: 'auth_Login');
      }
      rethrow;
    } on SocketException {
      throw ConnectionException();
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/data/datasource/handle_datasource_exception/i_handle_datasource_exception.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/i_handle_status_code_error.dart';

import '../model/account_model.dart';
import 'interfaces/i_account_datasource.dart';

class AccountDatasource implements IAccountDatasource {
  const AccountDatasource({
    required this.handleStatusCodeError,
    required this.handleDatasourceException,
    required this.apiAuthenticatedClient,
  });
  final IHandleStatusCodeError handleStatusCodeError;
  final IHandleDatasourceException handleDatasourceException;
  final IApiClient apiAuthenticatedClient;

  @override
  Future<AccountModel> getMyAccount() async =>
      await handleDatasourceException<AccountModel>(() async {
        final response = await apiAuthenticatedClient.get(
          route: 'account/getLoggedUser',
        );

        final failure = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (failure != null) {
          throw failure;
        }

        final model = AccountModel.maybeFromMap(response.data);
        if (model != null) {
          return model;
        } else {
          throw Exception();
        }
      });

  @override
  Future<void> updatePushNotification({
    required String? firebaseToken,
    required bool enabledPermission,
  }) async => await handleDatasourceException<void>(() async {
    final response = await apiAuthenticatedClient.put(
      route: 'account/pushNotification',
      requestBody: {
        "firebase_token": "$firebaseToken",
        "device_notification_enabled": enabledPermission,
      },
    );

    final failure = await handleStatusCodeError.hasException(
      statusCode: response.statusCode,
    );
    if (failure != null) {
      throw failure;
    }
  });

  @override
  Future<AccountModel> acceptTermsAndConditions({required int version}) async =>
      await handleDatasourceException<AccountModel>(() async {
        final response = await apiAuthenticatedClient.post(
          route: 'account/termsAccepted',
          requestBody: {"terms_version": "$version"},
        );

        final exception = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (exception != null) {
          throw exception;
        }

        final model = AccountModel.maybeFromMap(response.data);
        if (model != null) {
          return model;
        } else {
          throw Exception();
        }
      });

  @override
  Future<AccountModel> acceptPrivacyPolicy({required int version}) async =>
      await handleDatasourceException<AccountModel>(() async {
        final response = await apiAuthenticatedClient.post(
          route: 'account/privacyPolicyAccepted',
          requestBody: {"privacy_policy_version": "$version"},
        );

        final exception = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (exception != null) {
          throw exception;
        }

        final model = AccountModel.maybeFromMap(response.data);
        if (model != null) {
          return model;
        } else {
          throw Exception();
        }
      });

  @override
  Future<void> registerAppOpened() async =>
      await handleDatasourceException<void>(() async {
        final response = await apiAuthenticatedClient.put(
          route: 'account/userActive',
        );

        final exception = await handleStatusCodeError.hasException(
          statusCode: response.statusCode,
        );
        if (exception != null) {
          throw exception;
        }
      });
}

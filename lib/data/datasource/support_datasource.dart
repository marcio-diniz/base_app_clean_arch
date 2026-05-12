import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/data/datasource/handle_status_code_error/i_handle_status_code_error.dart';

import 'handle_datasource_exception/i_handle_datasource_exception.dart';
import 'interfaces/i_support_datasource.dart';

class SupportDatasource implements ISupportDatasource {
  const SupportDatasource({
    required this.handleStatusCodeError,
    required this.handleDatasourceException,
    required this.apiAuthenticatedClient,
  });

  final IHandleStatusCodeError handleStatusCodeError;
  final IHandleDatasourceException handleDatasourceException;
  final IApiClient apiAuthenticatedClient;

  @override
  Future<void> openSupportTicket({
    required String subject,
    required String description,
  }) async => await handleDatasourceException<void>(() async {
    final Map<String, dynamic> params = {
      'subject': subject,
      'description': description,
    };

    final response = await apiAuthenticatedClient.post(
      route: 'account/support/openTicket',
      requestBody: params,
    );

    final exception = await handleStatusCodeError.hasException(
      statusCode: response.statusCode,
    );
    if (exception != null) {
      throw exception;
    }
  });
}

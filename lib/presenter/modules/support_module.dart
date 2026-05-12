import 'package:base_app_clean_arch/core/modules/i_dependence_module.dart';
import 'package:base_app_clean_arch/core/services/api_client/i_api_client.dart';
import 'package:base_app_clean_arch/domain/usecase/support/i_open_support_ticket_use_case.dart';
import 'package:base_app_clean_arch/domain/usecase/support/open_support_ticket_use_case.dart';
import 'package:base_app_clean_arch/presenter/controller/support/open_support_ticket_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../core/services/api_client/api_client_implementation_type.dart';
import '../../data/datasource/handle_datasource_exception/i_handle_datasource_exception.dart';
import '../../data/datasource/handle_status_code_error/i_handle_status_code_error.dart';
import '../../data/datasource/interfaces/i_support_datasource.dart';
import '../../data/datasource/support_datasource.dart';
import '../../data/repository/handle_error/i_handle_error_on_request.dart';
import '../../data/repository/interfaces/i_support_repository.dart';
import '../../data/repository/support_repository.dart';

class SupportModule implements IDependenceModule {
  final getIt = GetIt.instance;
  @override
  void registerDependencies() {
    getIt.registerFactory<ISupportDatasource>(
      () => SupportDatasource(
        handleStatusCodeError: getIt<IHandleStatusCodeError>(),
        handleDatasourceException: getIt<IHandleDatasourceException>(),
        apiAuthenticatedClient: getIt<IApiClient>(
          instanceName: ApiClientImplementationType.apiAuthenticatedClient.name,
        ),
      ),
    );

    getIt.registerFactory<ISupportRepository>(
      () => SupportRepository(
        handleRequestOrErrors: getIt<IHandleErrorOnRequest>(),
        supportDatasource: getIt<ISupportDatasource>(),
      ),
    );

    getIt.registerFactory<IOpenSupportTicketUseCase>(
      () => OpenSupportTicketUseCase(
        supportRepository: getIt<ISupportRepository>(),
      ),
    );

    getIt.registerFactory(
      () => OpenSupportTicketCubit(
        openSupportTicketUseCase: getIt<IOpenSupportTicketUseCase>(),
      ),
    );
  }
}

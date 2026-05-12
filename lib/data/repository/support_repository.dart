import 'package:base_app_clean_arch/data/datasource/interfaces/i_support_datasource.dart';
import 'package:base_app_clean_arch/data/repository/handle_error/i_handle_error_on_request.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/repository/i_support_repository.dart';

class SupportRepository implements ISupportRepository {
  const SupportRepository({
    required this.supportDatasource,
    required this.handleRequestOrErrors,
  });

  final ISupportDatasource supportDatasource;
  final IHandleErrorOnRequest handleRequestOrErrors;

  @override
  Future<Either<Failure, void>> openSupportTicket({
    required String subject,
    required String description,
  }) async => await handleRequestOrErrors<void>(() async {
    return supportDatasource.openSupportTicket(
      subject: subject,
      description: description,
    );
  }, defaultMessageFailure: openSupportTicketFailureMessage);
}

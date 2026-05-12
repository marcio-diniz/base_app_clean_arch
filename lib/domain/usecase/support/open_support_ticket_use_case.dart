import 'package:base_app_clean_arch/data/repository/interfaces/i_support_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import 'i_open_support_ticket_use_case.dart';

class OpenSupportTicketUseCase implements IOpenSupportTicketUseCase {
  const OpenSupportTicketUseCase({required this.supportRepository});
  final ISupportRepository supportRepository;

  @override
  Future<Either<Failure, void>> call({
    required String subject,
    required String description,
  }) async {
    return supportRepository.openSupportTicket(
      subject: subject,
      description: description,
    );
  }
}

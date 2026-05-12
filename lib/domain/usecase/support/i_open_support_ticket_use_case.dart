import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IOpenSupportTicketUseCase {
  Future<Either<Failure, void>> call({
    required String subject,
    required String description,
  });
}

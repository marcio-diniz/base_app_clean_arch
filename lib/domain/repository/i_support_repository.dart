import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

abstract class ISupportRepository {
  Future<Either<Failure, void>> openSupportTicket({
    required String subject,
    required String description,
  });
}

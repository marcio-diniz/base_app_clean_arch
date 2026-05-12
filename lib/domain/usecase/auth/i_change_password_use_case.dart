import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IChangePasswordUseCase {
  Future<Either<Failure, void>> call({
    required String phone,
    required String password,
    required String confirmationCode,
  });
}

import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IForgotPasswordUseCase {
  Future<Either<Failure, void>> call({
    required String phone,
  });
}

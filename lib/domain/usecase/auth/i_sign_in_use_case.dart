import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class ISignInUseCase {
  Future<Either<Failure, void>> call({
    required String phone,
    required String password,
  });
}

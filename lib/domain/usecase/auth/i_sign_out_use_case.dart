import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class ISignOutUseCase {
  Future<Either<Failure, void>> call();
}

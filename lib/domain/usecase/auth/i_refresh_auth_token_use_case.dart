import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IRefreshAuthTokenUseCase {
  Future<Either<Failure, void>> call();
}

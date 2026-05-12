import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

abstract class IStartAppFunction<T> {
  Future<Either<Failure, T>> getStart();
}

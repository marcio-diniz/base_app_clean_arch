import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class IHandleErrorOnRequest {
  Future<Either<Failure, T>> call<T>(
    Future<T> Function() call, {
    required String defaultMessageFailure,
    Map<Exception, Failure>? additionalValidationFailures,
  });
}

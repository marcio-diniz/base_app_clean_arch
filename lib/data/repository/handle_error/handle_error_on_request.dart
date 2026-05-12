import 'package:base_app_clean_arch/core/error/exceptions.dart';
import 'package:base_app_clean_arch/data/repository/handle_error/i_handle_error_on_request.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

class HandleErrorOnRequest implements IHandleErrorOnRequest {
  @override
  Future<Either<Failure, T>> call<T>(
    Future<T> Function() request, {
    required String defaultMessageFailure,
    Map<Exception, Failure>? additionalValidationFailures,
  }) async {
    try {
      final result = await request();
      return Right(result);
    } catch (e) {
      if (e is ServerException) {
        return const Left(ServerFailure());
      }
      if (e is ConnectionException) {
        return const Left(NoInternetFailure());
      }
      if (e is CacheIsEmptyException) {
        return const Left(CacheIsEmptyFailure());
      }
      if (e is RefreshTokenException) {
        return const Left(RefreshTokenFailure());
      }

      if (additionalValidationFailures != null &&
          additionalValidationFailures.isNotEmpty) {
        for (final entry in additionalValidationFailures.entries) {
          if (entry.key.runtimeType == e.runtimeType) {
            return Left(entry.value);
          }
        }
      }
      return Left(Failure(message: defaultMessageFailure));
    }
  }
}

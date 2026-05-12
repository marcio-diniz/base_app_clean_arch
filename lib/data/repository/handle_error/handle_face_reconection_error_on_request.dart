import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import 'i_handle_error_on_request.dart';

class HandleFaceRecognitionErrorOnRequest implements IHandleErrorOnRequest {
  const HandleFaceRecognitionErrorOnRequest();

  @override
  Future<Either<Failure, T>> call<T>(
    Future<T> Function() request, {
    required String? defaultMessageFailure,
    Map<Exception, Failure>? additionalValidationFailures,
  }) async {
    try {
      final result = await request();
      return Right(result);
    } catch (e) {
      if (e is ServerException) {
        return const Left(ServerFailure());
      }
      if (e is DataEmptyException) {
        return const Left(
          DataEmptyFailure(message: myFaceRecognitionEmptyFailureMessage),
        );
      }
      if (e is TooManyItemsException) {
        return const Left(
          DataTooManyFailure(message: myFaceRecognitionTooManyFailureMessage),
        );
      }
      if (e is FaceCroppedException) {
        return const Left(
          FaceDecentralizedFailure(
              message: myFaceRecognitionDecentralizedInYFailureMessage),
        );
      }
      return const Left(
        Failure(message: myFaceRecognitionFailureMessage),
      );
    }
  }
}

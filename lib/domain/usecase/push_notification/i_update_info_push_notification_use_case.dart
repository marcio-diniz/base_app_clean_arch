import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class IUpdateInfoPushNotificationUseCase {
  Future<Either<Failure, void>> call({
    required String? firebaseToken,
    required bool enabledPermission,
  });
}

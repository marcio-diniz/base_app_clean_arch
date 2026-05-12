import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entity/account_entity.dart';
import '../../../domain/enums/type_request.dart';

abstract class IAccountRepository {
  Future<Either<Failure, AccountEntity>> getAccount({
    required TypeRequest typeRequest,
  });

  Future<Either<Failure, void>> updatePushPermission({
    required String? firebaseToken,
    required bool enabledPermission,
  });

  Future<Either<Failure, AccountEntity>> acceptTermsAndConditions({
    required int version,
  });

  Future<Either<Failure, AccountEntity>> acceptPrivacyPolicy({
    required int version,
  });

  Future<Either<Failure, void>> registerAppOpened();
}

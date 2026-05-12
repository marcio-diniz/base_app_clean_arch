import 'package:base_app_clean_arch/domain/entity/account_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class IAcceptPrivacyPolicyUseCase {
  Future<Either<Failure, AccountEntity>> call({required int version});
}

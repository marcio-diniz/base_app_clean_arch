import 'package:base_app_clean_arch/domain/entity/account_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../enums/type_request.dart';

abstract class IGetMyAccountUseCase {
  Future<Either<Failure, AccountEntity>> call({
    required TypeRequest typeRequest,
  });
}

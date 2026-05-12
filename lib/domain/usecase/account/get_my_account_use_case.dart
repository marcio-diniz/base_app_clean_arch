import 'package:base_app_clean_arch/domain/usecase/account/i_get_my_account_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/i_account_repository.dart';
import '../../entity/account_entity.dart';
import '../../enums/type_request.dart';

class GetMyAccountUseCase implements IGetMyAccountUseCase {
  const GetMyAccountUseCase({required this.accountRepository});
  final IAccountRepository accountRepository;

  @override
  Future<Either<Failure, AccountEntity>> call({
    required TypeRequest typeRequest,
  }) => accountRepository.getAccount(typeRequest: typeRequest);
}

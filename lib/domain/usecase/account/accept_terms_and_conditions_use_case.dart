import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../data/repository/interfaces/i_account_repository.dart';
import '../../entity/account_entity.dart';
import 'i_accept_terms_and_conditions_use_case.dart';

class AcceptTermsAndConditionsUseCase
    implements IAcceptTermsAndConditionsUseCase {
  const AcceptTermsAndConditionsUseCase({required this.accountRepository});
  final IAccountRepository accountRepository;

  @override
  Future<Either<Failure, AccountEntity>> call({
    required int version,
  }) =>
      accountRepository.acceptTermsAndConditions(version: version);
}

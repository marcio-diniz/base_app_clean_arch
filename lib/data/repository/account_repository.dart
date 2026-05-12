import 'package:base_app_clean_arch/data/datasource/interfaces/i_account_cache_datasource.dart';
import 'package:base_app_clean_arch/data/datasource/interfaces/i_account_datasource.dart';
import 'package:base_app_clean_arch/data/mapper/account_mapper.dart';
import 'package:base_app_clean_arch/data/repository/handle_error/i_handle_error_on_request.dart';
import 'package:base_app_clean_arch/domain/entity/account_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/enums/type_request.dart';
import '../../domain/repository/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  const AccountRepository({
    required this.accountDatasource,
    required this.accountCacheDatasource,
    required this.handleRequestOrErrors,
  });

  final IAccountDatasource accountDatasource;
  final IAccountCacheDatasource accountCacheDatasource;
  final IHandleErrorOnRequest handleRequestOrErrors;

  @override
  Future<Either<Failure, AccountEntity>> getAccount({
    required TypeRequest typeRequest,
  }) async => await handleRequestOrErrors<AccountEntity>(() async {
    switch (typeRequest) {
      case TypeRequest.onlyCache:
        final result = await accountCacheDatasource.getMyAccount();
        return result.toAccountEntity();

      case TypeRequest.tryCacheIfNotValidUseRemote:
      case TypeRequest.onlyRemote:
        final result = await accountDatasource.getMyAccount();
        await accountCacheDatasource.setMyAccount(model: result);
        return result.toAccountEntity();
    }
  }, defaultMessageFailure: getMyAccountFailureMessage);

  @override
  Future<Either<Failure, void>> updatePushPermission({
    required String? firebaseToken,
    required bool enabledPermission,
  }) async => await handleRequestOrErrors<void>(() async {
    final result = await accountDatasource.updatePushNotification(
      firebaseToken: firebaseToken,
      enabledPermission: enabledPermission,
    );
    return result;
  }, defaultMessageFailure: getMyAccountFailureMessage);

  @override
  Future<Either<Failure, AccountEntity>> acceptTermsAndConditions({
    required int version,
  }) async => await handleRequestOrErrors<AccountEntity>(() async {
    final result = await accountDatasource.acceptTermsAndConditions(
      version: version,
    );

    await accountCacheDatasource.setMyAccount(model: result);
    return result.toAccountEntity();
  }, defaultMessageFailure: acceptTermsAndConditionsFailureMessage);

  @override
  Future<Either<Failure, AccountEntity>> acceptPrivacyPolicy({
    required int version,
  }) async => await handleRequestOrErrors<AccountEntity>(() async {
    final result = await accountDatasource.acceptPrivacyPolicy(
      version: version,
    );

    await accountCacheDatasource.setMyAccount(model: result);
    return result.toAccountEntity();
  }, defaultMessageFailure: acceptPrivacyPolicyFailureMessage);

  @override
  Future<Either<Failure, void>> registerAppOpened() async =>
      await handleRequestOrErrors<void>(() async {
        return await accountDatasource.registerAppOpened();
      }, defaultMessageFailure: serverFailureMessage);
}

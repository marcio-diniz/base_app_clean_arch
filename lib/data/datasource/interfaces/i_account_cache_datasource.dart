import '../../model/account_model.dart';

abstract class IAccountCacheDatasource {
  Future<AccountModel> getMyAccount();

  Future<void> setMyAccount({
    required AccountModel model,
  });
}

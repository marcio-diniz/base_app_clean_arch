import 'package:base_app_clean_arch/core/services/cache/i_cache_service.dart';
import 'package:base_app_clean_arch/data/model/account_model.dart';

import '../../core/error/exceptions.dart';
import 'interfaces/i_account_cache_datasource.dart';

class AccountCacheDatasource implements IAccountCacheDatasource {
  const AccountCacheDatasource({required this.cacheService});

  final ICacheService cacheService;

  static const String _getMyAccountCacheKey = '_getMyAccountCacheKey';

  @override
  Future<AccountModel> getMyAccount() async {
    final model = await cacheService.getModel<AccountModel>(
      key: _getMyAccountCacheKey,
      maybeFromMap: AccountModel.maybeFromMap,
    );
    if (model == null) {
      throw CacheIsEmptyException();
    }
    return model;
  }

  @override
  Future<void> setMyAccount({required AccountModel model}) async {
    await cacheService.setModel(key: _getMyAccountCacheKey, model: model);
  }
}

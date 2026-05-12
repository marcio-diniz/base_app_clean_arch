import 'package:base_app_clean_arch/data/mapper/account_mapper.dart';
import 'package:base_app_clean_arch/data/model/account_model.dart';
import 'package:base_app_clean_arch/domain/entity/account_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/factory/account_factory.dart';
import 'test_convert_model_entity.dart';
import 'test_convert_model_map.dart';

void main() {
  group('AccountModel', () {
    final accountFactory = AccountFactory();
    final accountEntity = accountFactory.createEntity();
    final accountModel = accountFactory.createModel();
    final accountMap = accountFactory.createMap();

    testConvertModelEntity<AccountModel, AccountEntity>(
      model: accountModel,
      entity: accountEntity,
      toModel: (entity) => entity.toAccountModel(),
      toEntity: (model) => model.toAccountEntity(),
    );

    testConvertModelMap<AccountModel>(
      model: accountModel,
      map: accountMap,
      fromMap: (map) => AccountModel.fromMap(map),
    );
  });
}

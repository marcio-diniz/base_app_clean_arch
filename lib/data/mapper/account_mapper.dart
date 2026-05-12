import '../../domain/entity/account_entity.dart';
import '../model/account_model.dart';

extension AccountModelToEntityMapper on AccountModel {
  AccountEntity toAccountEntity() => AccountEntity(
    id: id,
    name: name,
    email: email,
    phone: phone,
    termsAndConditionsVersionAccepted: termsAndConditionsVersionAccepted,
    privacyPolicyVersionAccepted: privacyPolicyVersionAccepted,
  );
}

extension AccountEntityToModelMapper on AccountEntity {
  AccountModel toAccountModel() => AccountModel(
    id: id,
    name: name,
    email: email,
    phone: phone,
    termsAndConditionsVersionAccepted: termsAndConditionsVersionAccepted,
    privacyPolicyVersionAccepted: privacyPolicyVersionAccepted,
  );
}

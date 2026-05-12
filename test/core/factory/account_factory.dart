import 'package:base_app_clean_arch/data/model/account_model.dart';
import 'package:base_app_clean_arch/domain/entity/account_entity.dart';

class AccountFactory {
  final String id = 'account_id';
  final String name = 'João da Silva';
  final String email = 'joao.silva@arivi.ai';
  final String phone = '+5511999999999';
  final String cpf = '123.456.789-00';
  final int termsAndConditionsVersionAccepted = 1;
  final int privacyPolicyVersionAccepted = 1;
  final bool enableAnalytics = true;

  AccountEntity createEntity() {
    return AccountEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      termsAndConditionsVersionAccepted: termsAndConditionsVersionAccepted,
      privacyPolicyVersionAccepted: privacyPolicyVersionAccepted,
    );
  }

  AccountModel createModel() {
    return AccountModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      termsAndConditionsVersionAccepted: termsAndConditionsVersionAccepted,
      privacyPolicyVersionAccepted: privacyPolicyVersionAccepted,
    );
  }

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'terms_and_conditions_version_accepted':
          termsAndConditionsVersionAccepted,
      'privacy_policy_version_accepted': privacyPolicyVersionAccepted,
    };
  }
}

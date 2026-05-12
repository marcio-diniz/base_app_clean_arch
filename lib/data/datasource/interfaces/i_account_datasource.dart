import 'package:base_app_clean_arch/data/model/account_model.dart';

abstract class IAccountDatasource {
  Future<AccountModel> getMyAccount();

  Future<void> updatePushNotification({
    required String? firebaseToken,
    required bool enabledPermission,
  });

  Future<AccountModel> acceptTermsAndConditions({required int version});

  Future<AccountModel> acceptPrivacyPolicy({required int version});

  Future<void> registerAppOpened();
}

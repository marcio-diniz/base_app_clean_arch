import '../../domain/entity/app_settings_entity.dart';
import '../model/app_settings_model.dart';

extension AppSettingsModelToEntityMapper on AppSettingsModel {
  AppSettingsEntity toAppSettingsEntity() {
    return AppSettingsEntity(
      minVersionNumberBuild: minVersionNumberBuild,
      minVersionName: minVersionName,
      minVersionReleaseNotes: minVersionReleaseNotes,
      appStoreUrl: appStoreUrl,
      playStoreUrl: playStoreUrl,
      termsVersion: termsVersion,
      termsUrl: termsUrl,
      privacyPolicyUrl: privacyPolicyUrl,
      privacyPolicyVersion: privacyPolicyVersion,
      supportUrl: supportUrl,
    );
  }
}

extension AppSettingsEntityToModelMapper on AppSettingsEntity {
  AppSettingsModel toAppSettingsModel() {
    return AppSettingsModel(
      minVersionNumberBuild: minVersionNumberBuild,
      minVersionName: minVersionName,
      minVersionReleaseNotes: minVersionReleaseNotes,
      appStoreUrl: appStoreUrl,
      playStoreUrl: playStoreUrl,
      termsVersion: termsVersion,
      termsUrl: termsUrl,
      privacyPolicyUrl: privacyPolicyUrl,
      privacyPolicyVersion: privacyPolicyVersion,
      supportUrl: supportUrl,
    );
  }
}

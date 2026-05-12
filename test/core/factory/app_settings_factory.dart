import 'package:base_app_clean_arch/data/model/app_settings_model.dart';
import 'package:base_app_clean_arch/domain/entity/app_settings_entity.dart';

class AppSettingsFactory {
  final int minVersionNumberBuild = 1;
  final String minVersionName = '1.0.0';
  final String minVersionReleaseNotes = 'Initial release';
  final String appStoreUrl = 'https://appstore.com/arivi';
  final String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.arivi.app';
  final int termsVersion = 1;
  final String termsUrl = 'https://arivi.com/terms';
  final String privacyPolicyUrl = 'https://arivi.com/privacy';
  final int privacyPolicyVersion = 1;
  final String supportUrl = 'https://arivi.com/support';

  AppSettingsEntity createEntity() {
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

  AppSettingsModel createModel() {
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

  Map<String, dynamic> createMap() {
    return {
      'min_version_number_build': minVersionNumberBuild,
      'min_version_name': minVersionName,
      'min_version_release_notes': minVersionReleaseNotes,
      'app_store_url': appStoreUrl,
      'play_store_url': playStoreUrl,
      'terms_version': termsVersion,
      'terms_url': termsUrl,
      'privacy_policy_url': privacyPolicyUrl,
      'privacy_policy_version': privacyPolicyVersion,
      'support_url': supportUrl,
    };
  }
}

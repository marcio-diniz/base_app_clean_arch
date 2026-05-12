import 'package:equatable/equatable.dart';

import 'model.dart';

class AppSettingsModel extends Equatable implements Model {
  const AppSettingsModel({
    required this.minVersionNumberBuild,
    required this.minVersionName,
    required this.minVersionReleaseNotes,
    required this.appStoreUrl,
    required this.playStoreUrl,
    required this.termsVersion,
    required this.termsUrl,
    required this.privacyPolicyUrl,
    required this.privacyPolicyVersion,
    required this.supportUrl,
  });

  final int minVersionNumberBuild;
  final String minVersionName;
  final String minVersionReleaseNotes;
  final String appStoreUrl;
  final String playStoreUrl;
  final int termsVersion;
  final String termsUrl;
  final String privacyPolicyUrl;
  final int privacyPolicyVersion;
  final String supportUrl;

  @override
  List<Object?> get props => [
    minVersionNumberBuild,
    minVersionName,
    minVersionReleaseNotes,
    appStoreUrl,
    playStoreUrl,
    termsVersion,
    termsUrl,
    privacyPolicyUrl,
    privacyPolicyVersion,
    supportUrl,
  ];

  @override
  factory AppSettingsModel.fromMap(Map<String, dynamic> data) =>
      AppSettingsModel(
        minVersionNumberBuild: data['min_version_number_build'] as int? ?? 0,
        minVersionName: data['min_version_name'] as String? ?? '',
        minVersionReleaseNotes:
            data['min_version_release_notes'] as String? ?? '',
        appStoreUrl: data['app_store_url'] as String? ?? '',
        playStoreUrl: data['play_store_url'] as String? ?? '',
        termsVersion: data['terms_version'] as int? ?? 0,
        termsUrl: data['terms_url'] as String? ?? '',
        privacyPolicyUrl: data['privacy_policy_url'] as String? ?? '',
        privacyPolicyVersion: data['privacy_policy_version'] as int? ?? 0,
        supportUrl: data['support_url'] as String? ?? '',
      );

  static AppSettingsModel? maybeFromMap(dynamic data) => data is Map
      ? AppSettingsModel.fromMap(data.cast<String, dynamic>())
      : null;

  @override
  Map<String, dynamic> toMap() => {
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

  @override
  String toString() => 'AppSettingsModel(${toMap()})';
}

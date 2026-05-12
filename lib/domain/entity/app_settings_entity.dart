import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:equatable/equatable.dart';

class AppSettingsEntity extends Equatable implements Entity {
  const AppSettingsEntity({
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
  AppSettingsEntity copyWith({
    int? minVersionNumberBuild,
    String? minVersionName,
    String? minVersionReleaseNotes,
    String? appStoreUrl,
    String? playStoreUrl,
    int? termsVersion,
    String? termsUrl,
    String? privacyPolicyUrl,
    int? privacyPolicyVersion,
    String? supportUrl,
  }) => AppSettingsEntity(
    minVersionNumberBuild: minVersionNumberBuild ?? this.minVersionNumberBuild,
    minVersionName: minVersionName ?? this.minVersionName,
    minVersionReleaseNotes:
        minVersionReleaseNotes ?? this.minVersionReleaseNotes,
    appStoreUrl: appStoreUrl ?? this.appStoreUrl,
    playStoreUrl: playStoreUrl ?? this.playStoreUrl,
    termsVersion: termsVersion ?? this.termsVersion,
    termsUrl: termsUrl ?? this.termsUrl,
    privacyPolicyUrl: privacyPolicyUrl ?? this.privacyPolicyUrl,
    privacyPolicyVersion: privacyPolicyVersion ?? this.privacyPolicyVersion,
    supportUrl: supportUrl ?? this.supportUrl,
  );
}

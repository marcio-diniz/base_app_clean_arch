import 'package:equatable/equatable.dart';

import 'model.dart';

class AccountModel extends Equatable implements Model {
  const AccountModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.termsAndConditionsVersionAccepted,
    required this.privacyPolicyVersionAccepted,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final int termsAndConditionsVersionAccepted;
  final int privacyPolicyVersionAccepted;

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    termsAndConditionsVersionAccepted,
    privacyPolicyVersionAccepted,
  ];

  @override
  factory AccountModel.fromMap(Map<String, dynamic> data) => AccountModel(
    id: data['id'] as String? ?? '',
    name: data['name'] as String? ?? '',
    email: data['email'] as String? ?? '',
    phone: data['phone'] as String? ?? '',
    termsAndConditionsVersionAccepted:
        data['terms_and_conditions_version_accepted'] as int? ?? 0,
    privacyPolicyVersionAccepted:
        data['privacy_policy_version_accepted'] as int? ?? 0,
  );

  static AccountModel? maybeFromMap(dynamic data) =>
      data is Map ? AccountModel.fromMap(data.cast<String, dynamic>()) : null;

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'terms_and_conditions_version_accepted': termsAndConditionsVersionAccepted,
    'privacy_policy_version_accepted': privacyPolicyVersionAccepted,
  };

  @override
  String toString() => 'AccountModel(${toMap()})';
}

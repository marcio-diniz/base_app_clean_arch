import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable implements Entity {
  const AccountEntity({
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
  List<Object> get props => [
    id,
    name,
    email,
    phone,
    termsAndConditionsVersionAccepted,
    privacyPolicyVersionAccepted,
  ];

  @override
  AccountEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    int? termsAndConditionsVersionAccepted,
    int? privacyPolicyVersionAccepted,
  }) => AccountEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    termsAndConditionsVersionAccepted:
        termsAndConditionsVersionAccepted ??
        this.termsAndConditionsVersionAccepted,
    privacyPolicyVersionAccepted:
        privacyPolicyVersionAccepted ?? this.privacyPolicyVersionAccepted,
  );
}

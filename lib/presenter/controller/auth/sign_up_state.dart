import 'package:equatable/equatable.dart';

enum SignUpStateStatus {
  initial,
  onChange,
  loading,
  loadingButton,
  success,
  failure,
  alreadyPhoneFailure,
}

class SignUpState extends Equatable {
  const SignUpState._({
    this.obscurePassword = true,
    this.termsOfUseAccepted = false,
    this.privacyPolicyAccepted = false,
    this.messageFailure,
    required this.status,
  });

  final bool obscurePassword;
  final bool termsOfUseAccepted;
  final bool privacyPolicyAccepted;
  final String? messageFailure;
  final SignUpStateStatus status;

  const SignUpState.initial() : this._(status: SignUpStateStatus.initial);

  @override
  List<Object?> get props => [
    obscurePassword,
    termsOfUseAccepted,
    privacyPolicyAccepted,
    messageFailure,
    status,
  ];

  SignUpState copyWith({
    bool? obscurePassword,
    bool? termsOfUseAccepted,
    bool? privacyPolicyAccepted,
    String? messageFailure,
    required SignUpStateStatus status,
  }) => SignUpState._(
    status: status,
    obscurePassword: obscurePassword ?? this.obscurePassword,
    termsOfUseAccepted: termsOfUseAccepted ?? this.termsOfUseAccepted,
    privacyPolicyAccepted: privacyPolicyAccepted ?? this.privacyPolicyAccepted,
    messageFailure: messageFailure,
  );
}

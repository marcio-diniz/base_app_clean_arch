import 'package:equatable/equatable.dart';

enum SignInStateStatus {
  initial,
  onChange,
  loading,
  success,
  failure,
  phoneOrPasswordFailure,
}

class SignInState extends Equatable {
  const SignInState._({
    this.obscurePassword = true,
    this.enableBiometrics = false,
    this.messageFailure,
    required this.status,
  });

  final bool obscurePassword;
  final bool enableBiometrics;
  final String? messageFailure;
  final SignInStateStatus status;

  const SignInState.initial()
      : this._(
          status: SignInStateStatus.initial,
        );

  @override
  List<Object?> get props => [
        obscurePassword,
        enableBiometrics,
        messageFailure,
        status,
      ];

  SignInState copyWith({
    bool? obscurePassword,
    bool? enableBiometrics,
    String? messageFailure,
    required SignInStateStatus status,
  }) =>
      SignInState._(
        status: status,
        obscurePassword: obscurePassword ?? this.obscurePassword,
        enableBiometrics: enableBiometrics ?? this.enableBiometrics,
        messageFailure: messageFailure,
      );
}

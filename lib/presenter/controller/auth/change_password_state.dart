import 'package:equatable/equatable.dart';

import '../state_enum.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState._({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.messageFailure,
    required this.status,
  });

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? messageFailure;
  final StateEnum status;

  const ChangePasswordState.initial()
      : this._(
          status: StateEnum.initial,
        );

  @override
  List<Object?> get props => [
        obscurePassword,
        obscureConfirmPassword,
        messageFailure,
        status,
      ];

  ChangePasswordState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? messageFailure,
    required StateEnum status,
  }) =>
      ChangePasswordState._(
        status: status,
        obscurePassword: obscurePassword ?? this.obscurePassword,
        obscureConfirmPassword:
            obscureConfirmPassword ?? this.obscureConfirmPassword,
        messageFailure: messageFailure,
      );
}

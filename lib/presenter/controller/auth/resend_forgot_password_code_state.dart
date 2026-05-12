import 'package:equatable/equatable.dart';

import '../state_enum.dart';

class ResendForgotPasswordCodeState extends Equatable {
  const ResendForgotPasswordCodeState._({
    this.enabledResendCode = false,
    required this.enableResendCodeInSeconds,
    this.messageFailure,
    this.messageSuccess,
    required this.status,
  });

  final bool enabledResendCode;
  final int enableResendCodeInSeconds;
  final String? messageFailure;
  final String? messageSuccess;
  final StateEnum status;

  const ResendForgotPasswordCodeState.initial()
      : this._(
          status: StateEnum.initial,
          enableResendCodeInSeconds: 60,
        );

  @override
  List<Object?> get props => [
        enabledResendCode,
        enableResendCodeInSeconds,
        messageFailure,
        messageSuccess,
        status,
      ];

  ResendForgotPasswordCodeState copyWith({
    bool? enabledResendCode,
    int? enableResendCodeInSeconds,
    String? messageFailure,
    String? messageSuccess,
    required StateEnum status,
  }) =>
      ResendForgotPasswordCodeState._(
        status: status,
        enabledResendCode: enabledResendCode ?? this.enabledResendCode,
        enableResendCodeInSeconds:
            enableResendCodeInSeconds ?? this.enableResendCodeInSeconds,
        messageFailure: messageFailure,
        messageSuccess: messageSuccess,
      );
}

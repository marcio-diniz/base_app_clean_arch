import 'dart:async';

import 'package:base_app_clean_arch/domain/usecase/auth/i_resend_forgot_password_code_use_case.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/resend_forgot_password_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/auth/i_auth_manager.dart';
import '../../../domain/enums/send_code_type_enum.dart';
import '../state_enum.dart';

class ResendForgotPasswordCodeCubit
    extends Cubit<ResendForgotPasswordCodeState> {
  ResendForgotPasswordCodeCubit({
    required IResendForgotPasswordCodeUseCase resendForgotPasswordCodeUseCase,
    required IAuthManager customAuthManager,
  }) : _resendForgotPasswordCodeUseCase = resendForgotPasswordCodeUseCase,
       _customAuthManager = customAuthManager,
       super(const ResendForgotPasswordCodeState.initial());

  final IResendForgotPasswordCodeUseCase _resendForgotPasswordCodeUseCase;
  final IAuthManager _customAuthManager;

  static const int _resendCodeTimeoutSeconds = 60;
  Timer? _enableResendCodeTimer;

  void startEnableResendCodeTimer() {
    _enableResendCodeTimer?.cancel();
    emit(
      state.copyWith(
        enabledResendCode: false,
        enableResendCodeInSeconds: _resendCodeTimeoutSeconds,
        status: StateEnum.initial,
      ),
    );
    _enableResendCodeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.enableResendCodeInSeconds <= 1) {
        _enableResendCodeTimer?.cancel();
        emit(
          state.copyWith(enabledResendCode: true, status: StateEnum.initial),
        );
        return;
      }
      emit(
        state.copyWith(
          enableResendCodeInSeconds: state.enableResendCodeInSeconds - 1,
          status: StateEnum.initial,
        ),
      );
    });
  }

  Future<void> resendForgotPasswordCode({
    required SendCodeTypeEnum sendCodeType,
  }) async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _resendForgotPasswordCodeUseCase(
      phone: _customAuthManager.fullPhoneNumber,
      sendCodeType: sendCodeType,
    );
    either.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StateEnum.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (success) async {
        emit(
          state.copyWith(
            status: StateEnum.success,
            messageSuccess: sendCodeType == SendCodeTypeEnum.sms
                ? 'O código foi enviado por SMS com sucesso!'
                : 'Em breve você receberá uma ligação com o código!',
          ),
        );
        startEnableResendCodeTimer();
      },
    );
  }

  void cancelTimer() {
    _enableResendCodeTimer?.cancel();
  }
}

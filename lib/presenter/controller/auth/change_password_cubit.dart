import 'package:base_app_clean_arch/domain/usecase/auth/i_change_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/auth/i_auth_manager.dart';
import '../state_enum.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required IChangePasswordUseCase changePasswordUseCase,
    required IAuthManager customAuthManager,
  }) : _changePasswordUseCase = changePasswordUseCase,
       _customAuthManager = customAuthManager,
       super(const ChangePasswordState.initial());

  final IChangePasswordUseCase _changePasswordUseCase;
  final IAuthManager _customAuthManager;

  void toggleObscurePassword() {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
        status: StateEnum.initial,
      ),
    );
  }

  void toggleObscureConfirmPassword() {
    emit(
      state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
        status: StateEnum.initial,
      ),
    );
  }

  Future<void> changePassword({
    required String password,
    required String confirmationCode,
  }) async {
    final phone = _customAuthManager.fullPhoneNumber;
    if (phone == null) {
      emit(
        state.copyWith(
          status: StateEnum.failure,
          messageFailure: 'Número de telefone não encontrado.',
        ),
      );
      return;
    }
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _changePasswordUseCase(
      phone: phone,
      password: password,
      confirmationCode: confirmationCode,
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
        await _customAuthManager.setPassword(password: password);
        emit(state.copyWith(status: StateEnum.success));
      },
    );
  }
}

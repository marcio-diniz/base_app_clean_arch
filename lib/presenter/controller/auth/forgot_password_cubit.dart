import 'package:base_app_clean_arch/domain/usecase/auth/i_forgot_password_use_case.dart';
import 'package:base_app_clean_arch/presenter/controller/simple_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/auth/i_auth_manager.dart';
import '../../../core/util/phone_utils.dart';
import '../state_enum.dart';

class ForgotPasswordCubit extends Cubit<SimpleState<void, StateEnum>> {
  ForgotPasswordCubit({
    required IForgotPasswordUseCase forgotPasswordUseCase,
    required IAuthManager customAuthManager,
  }) : _forgotPasswordUseCase = forgotPasswordUseCase,
       _customAuthManager = customAuthManager,
       super(const SimpleState.initial(StateEnum.initial));

  final IForgotPasswordUseCase _forgotPasswordUseCase;
  final IAuthManager _customAuthManager;

  Future<void> forgotPassword({
    required String countryCode,
    required String phone,
  }) async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _forgotPasswordUseCase(
      phone: PhoneUtils.formatPhoneNumber(
        countryCode: countryCode,
        phone: phone,
      ),
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
        await _customAuthManager.setPhoneNumber(phoneNumber: phone);
        emit(state.copyWith(status: StateEnum.success));
      },
    );
  }
}

import 'dart:async';
import 'package:base_app_clean_arch/core/error/failures.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/i_register_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/auth/i_auth_manager.dart';
import '../../../core/util/phone_utils.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required IRegisterUserUseCase signUpUseCase,
    required IAuthManager customAuthManager,
  }) : _signUpUseCase = signUpUseCase,
       _customAuthManager = customAuthManager,
       super(const SignUpState.initial());

  final IRegisterUserUseCase _signUpUseCase;
  final IAuthManager _customAuthManager;

  Future<void> signUp({
    required String password,
    required String confirmPassword,
    required String countryCode,
    required String phone,
    required int termsVersion,
    required int privacyPolicyVersion,
  }) async {
    emit(state.copyWith(status: SignUpStateStatus.loading));
    final either = await _signUpUseCase(
      password: password,
      phone: PhoneUtils.formatPhoneNumber(
        countryCode: countryCode,
        phone: phone,
      ),
      termsVersion: termsVersion,
      privacyPolicyVersion: privacyPolicyVersion,
    );
    either.fold(
      (failure) {
        if (failure is AlreadyPhoneFailure) {
          emit(state.copyWith(status: SignUpStateStatus.alreadyPhoneFailure));
          return;
        }
        emit(
          state.copyWith(
            status: SignUpStateStatus.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) async {
        await _customAuthManager.setPhoneNumber(phoneNumber: phone);
        await _customAuthManager.setPassword(password: password);
        emit(state.copyWith(status: SignUpStateStatus.success));
      },
    );
  }

  void toggleObscurePassword() {
    emit(
      state.copyWith(
        status: SignUpStateStatus.onChange,
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void onChangeTermsOfUseAccepted({required bool? accepted}) {
    emit(
      state.copyWith(
        status: SignUpStateStatus.onChange,
        termsOfUseAccepted: accepted,
      ),
    );
  }

  void onChangePrivacyPolicyAccepted({required bool? accepted}) {
    emit(
      state.copyWith(
        status: SignUpStateStatus.onChange,
        privacyPolicyAccepted: accepted,
      ),
    );
  }
}

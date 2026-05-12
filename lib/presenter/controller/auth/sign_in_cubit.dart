import 'dart:async';
import 'package:base_app_clean_arch/core/error/failures.dart';
import 'package:base_app_clean_arch/core/util/phone_utils.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/auth/i_auth_manager.dart';
import '../../../core/services/auth_biometrics/i_auth_biometrics_service.dart';
import '../../../domain/usecase/auth/i_sign_in_use_case.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required ISignInUseCase signInUseCase,
    required IAuthBiometricsService authBiometricsService,
    required IAuthManager customAuthManager,
  }) : _signInUseCase = signInUseCase,
       _authBiometricsService = authBiometricsService,
       _customAuthManager = customAuthManager,
       super(const SignInState.initial());

  final ISignInUseCase _signInUseCase;
  final IAuthBiometricsService _authBiometricsService;
  final IAuthManager _customAuthManager;

  Future<void> init() async {
    final enableBiometrics = _customAuthManager.enableBiometric;
    emit(
      state.copyWith(
        status: SignInStateStatus.initial,
        enableBiometrics: enableBiometrics,
      ),
    );
    if (enableBiometrics) {
      biometric();
    }
  }

  Future<void> biometric() async {
    final isAuthenticated = await _authBiometricsService.authenticate();
    final password = _customAuthManager.password;
    final countryCode = _customAuthManager.countryCode;
    final phoneNumber = _customAuthManager.phoneNumber;
    if (isAuthenticated && password != null && phoneNumber != null) {
      await signIn(
        countryCode: countryCode,
        phone: phoneNumber,
        password: password,
      );
    } else {
      emit(
        state.copyWith(
          status: SignInStateStatus.failure,
          messageFailure: 'Não foi possível realizar a biometria!',
        ),
      );
      await _customAuthManager.setEnableBiometrics(enable: false);
    }
  }

  Future<void> signIn({
    required String countryCode,
    required String phone,
    required String password,
  }) async {
    emit(state.copyWith(status: SignInStateStatus.loading));
    final either = await _signInUseCase(
      password: password,
      phone: PhoneUtils.formatPhoneNumber(
        countryCode: countryCode,
        phone: phone,
      ),
    );
    either.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(
            state.copyWith(
              status: SignInStateStatus.phoneOrPasswordFailure,
              messageFailure: failure.message,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: SignInStateStatus.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) async {
        await _customAuthManager.setPhoneNumber(phoneNumber: phone);
        await _customAuthManager.setPassword(password: password);
        emit(state.copyWith(status: SignInStateStatus.success));
      },
    );
  }

  void toggleObscurePassword() {
    emit(
      state.copyWith(
        status: SignInStateStatus.onChange,
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void setEnableBiometrics(bool enableBiometrics) {
    _customAuthManager.setEnableBiometrics(enable: enableBiometrics);

    emit(
      state.copyWith(
        status: SignInStateStatus.onChange,
        enableBiometrics: enableBiometrics,
      ),
    );

    if (enableBiometrics &&
        (_customAuthManager.password?.isNotEmpty ?? false)) {
      biometric();
    }
  }
}

import 'package:base_app_clean_arch/presenter/controller/simple_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/auth/i_sign_out_use_case.dart';
import '../state_enum.dart';

class SignOutCubit extends Cubit<SimpleState<void, StateEnum>> {
  SignOutCubit({required ISignOutUseCase signOutUseCase})
    : _signOutUseCase = signOutUseCase,
      super(const SimpleState.initial(StateEnum.initial));

  final ISignOutUseCase _signOutUseCase;

  Future<void> signOut() async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _signOutUseCase();
    either.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StateEnum.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (success) {
        emit(state.copyWith(status: StateEnum.success));
      },
    );
  }
}

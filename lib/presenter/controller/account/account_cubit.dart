import 'dart:async';
import 'package:base_app_clean_arch/core/services/start_app/i_start_app_function.dart';
import 'package:base_app_clean_arch/domain/enums/type_request.dart';
import 'package:base_app_clean_arch/domain/usecase/account/i_accept_terms_and_conditions_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entity/account_entity.dart';
import '../../../domain/usecase/account/i_accept_privacy_policy_use_case.dart';
import '../../../domain/usecase/account/i_get_my_account_use_case.dart';
import '../simple_state.dart';
import '../state_enum.dart';

class AccountCubit extends Cubit<SimpleState<AccountEntity, StateEnum>>
    implements IStartAppFunction<AccountEntity> {
  AccountCubit({
    required IGetMyAccountUseCase getMyAccountUseCase,
    required IAcceptTermsAndConditionsUseCase acceptTermsAndConditionsUseCase,
    required IAcceptPrivacyPolicyUseCase acceptPrivacyPolicyUseCase,
  }) : _getMyAccountUseCase = getMyAccountUseCase,
       _acceptTermsAndConditionsUseCase = acceptTermsAndConditionsUseCase,
       _acceptPrivacyPolicyUseCase = acceptPrivacyPolicyUseCase,
       super(const SimpleState.initial(StateEnum.initial));

  final IGetMyAccountUseCase _getMyAccountUseCase;
  final IAcceptTermsAndConditionsUseCase _acceptTermsAndConditionsUseCase;
  final IAcceptPrivacyPolicyUseCase _acceptPrivacyPolicyUseCase;

  Future<void> getAccount({
    TypeRequest typeRequest = TypeRequest.onlyRemote,
  }) async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _getMyAccountUseCase(typeRequest: typeRequest);
    either.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StateEnum.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) {
        emit(state.copyWith(status: StateEnum.success, entity: entity));
      },
    );
  }

  Future<void> acceptTermsAndConditions({required int version}) async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _acceptTermsAndConditionsUseCase(version: version);
    either.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StateEnum.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) {
        emit(state.copyWith(status: StateEnum.success, entity: entity));
      },
    );
  }

  Future<void> acceptPrivacyPolicy({required int version}) async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _acceptPrivacyPolicyUseCase(version: version);
    either.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StateEnum.failure,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) {
        emit(state.copyWith(status: StateEnum.success, entity: entity));
      },
    );
  }

  @override
  Future<Either<Failure, AccountEntity>> getStart() async {
    await getAccount();
    if (state.status == StateEnum.success && state.entity != null) {
      return Right(state.entity!);
    }
    return Left(Failure(message: state.messageFailure ?? ''));
  }
}

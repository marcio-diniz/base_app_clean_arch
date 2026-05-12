import 'dart:async';
import 'package:base_app_clean_arch/domain/usecase/app_settings/i_get_app_settings_use_case.dart';
import 'package:base_app_clean_arch/core/services/start_app/i_start_app_function.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entity/app_settings_entity.dart';
import '../simple_state.dart';
import '../state_enum.dart';

class AppSettingsCubit extends Cubit<SimpleState<AppSettingsEntity, StateEnum>>
    implements IStartAppFunction<AppSettingsEntity> {
  AppSettingsCubit({required IGetAppSettingsUseCase getAppSettingsUseCase})
    : _getAppSettingsUseCase = getAppSettingsUseCase,
      super(const SimpleState.initial(StateEnum.initial));

  final IGetAppSettingsUseCase _getAppSettingsUseCase;

  Future<void> getAppSettings() async {
    emit(state.copyWith(status: StateEnum.loading));
    final either = await _getAppSettingsUseCase();
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

  Future<void> ensureAppSettings() async {
    if (state.entity == null) {
      await getAppSettings();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  Future<Either<Failure, AppSettingsEntity>> getStart() async {
    await getAppSettings();
    if (state.status == StateEnum.success && state.entity != null) {
      return Right(state.entity!);
    }
    return Left(Failure(message: state.messageFailure ?? ''));
  }
}

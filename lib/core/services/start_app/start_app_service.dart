import 'package:base_app_clean_arch/core/services/device_info/i_device_info_service.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/i_refresh_auth_token_use_case.dart';
import 'package:base_app_clean_arch/domain/usecase/push_notification/i_update_info_push_notification_use_case.dart';
import 'package:base_app_clean_arch/presenter/controller/simple_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/account_entity.dart';
import '../../../domain/entity/app_settings_entity.dart';
import '../../error/failures.dart';
import '../local_storage/i_local_storage_service.dart';
import '../notification/i_notification_service.dart';

import '../permission/i_permission_service.dart';
import 'i_start_app_function.dart';

enum StartAppEnum {
  initial,
  redirectToLogin,
  failureGetAppSettings,
  failureGetAccount,
  redirectToForceUpdate,
  redirectToTerms,
  redirectToPrivacyPolicy,
  complete,
}

class StartAppService extends Cubit<SimpleState<void, StartAppEnum>> {
  StartAppService({
    required IStartAppFunction<AppSettingsEntity> getAppSettings,
    required IStartAppFunction<AccountEntity> getAccount,
    required IPushNotificationService pushNotificationService,
    required IPermissionService permissionService,
    required ILocalStorageService localStorageService,
    required IUpdateInfoPushNotificationUseCase
    updateInfoPushNotificationUseCase,
    required IRefreshAuthTokenUseCase refreshAuthTokenUseCase,
    required IDeviceInfoService deviceInfoService,
  }) : _getAppSettings = getAppSettings,
       _getAccount = getAccount,
       _pushNotificationService = pushNotificationService,
       _permissionService = permissionService,
       _localStorageService = localStorageService,
       _updateInfoPushNotificationUseCase = updateInfoPushNotificationUseCase,
       _refreshAuthTokenUseCase = refreshAuthTokenUseCase,
       _deviceInfoService = deviceInfoService,
       super(const SimpleState.initial(StartAppEnum.initial));

  final IStartAppFunction<AccountEntity> _getAccount;
  final IStartAppFunction<AppSettingsEntity> _getAppSettings;
  final IPushNotificationService _pushNotificationService;
  final IPermissionService _permissionService;
  final ILocalStorageService _localStorageService;
  final IUpdateInfoPushNotificationUseCase _updateInfoPushNotificationUseCase;
  final IRefreshAuthTokenUseCase _refreshAuthTokenUseCase;
  final IDeviceInfoService _deviceInfoService;

  AppSettingsEntity? appSettingsEntity;
  AccountEntity? accountEntity;

  Future<void> init(BuildContext context) async {
    // is complete
    if (state.status == StartAppEnum.complete) return;

    final refreshEither = await _refreshAuthTokenUseCase.call();
    if (refreshEither.isLeft()) {
      final failure = refreshEither.swap().getOrElse(
        () => const Failure(message: ''),
      );
      emit(
        state.copyWith(
          status: StartAppEnum.redirectToLogin,
          messageFailure: failure.message,
        ),
      );
      return;
    }

    // get all data
    final responseAll = await Future.wait([
      _getAppSettings.getStart(),
      _getAccount.getStart(),
    ]);

    final appSettingsEither =
        responseAll[1] as Either<Failure, AppSettingsEntity>;
    final accountEither = responseAll[2] as Either<Failure, AccountEntity>;

    // get app settings
    appSettingsEither.fold(
      (failure) {
        return emit(
          state.copyWith(
            status: StartAppEnum.failureGetAppSettings,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) {
        appSettingsEntity = entity;
      },
    );
    if (appSettingsEntity == null) return;

    // get account
    accountEither.fold(
      (failure) {
        return emit(
          state.copyWith(
            status: StartAppEnum.failureGetAccount,
            messageFailure: failure.message,
          ),
        );
      },
      (entity) {
        accountEntity = entity;
      },
    );
    if (accountEntity == null) return;

    // force update
    if (await _deviceInfoService.getAppVersionNumber() <
        appSettingsEntity!.minVersionNumberBuild) {
      return emit(state.copyWith(status: StartAppEnum.redirectToForceUpdate));
    }

    // terms
    if (accountEntity!.termsAndConditionsVersionAccepted <
        appSettingsEntity!.termsVersion) {
      return emit(state.copyWith(status: StartAppEnum.redirectToTerms));
    }

    // privacy policy
    if (accountEntity!.privacyPolicyVersionAccepted <
        appSettingsEntity!.privacyPolicyVersion) {
      return emit(state.copyWith(status: StartAppEnum.redirectToPrivacyPolicy));
    }

    // enabled permission
    final enabledNotificationPermission = await _permissionService
        .getPushPermission();

    // last enabled permission
    //final lastEnabledNotificationPermission =
    //   await _localStorageService.lastNotificationPermission();

    // her change in notification permission
    String? firebaseToken;
    if (enabledNotificationPermission) {
      firebaseToken = await _pushNotificationService.getFCMToken();
    }

    // update info notification
    final either = await _updateInfoPushNotificationUseCase.call(
      firebaseToken: firebaseToken,
      enabledPermission: enabledNotificationPermission,
    );

    either.fold((failure) {}, (success) {
      _localStorageService.setLastNotificationPermission(
        enabledNotificationPermission,
      );
    });

    // complete
    emit(state.copyWith(status: StartAppEnum.complete));
    return;
  }
}

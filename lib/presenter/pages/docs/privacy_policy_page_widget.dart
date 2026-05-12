import 'package:base_app_clean_arch/core/design_system/components/custom_button_widget.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:base_app_clean_arch/core/widget/custom_web_view.dart';
import 'package:base_app_clean_arch/presenter/controller/account/account_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/design_system/components/custom_snack_bar.dart';
import '../../../core/services/navigation/i_navigation_service.dart';
import '../../../domain/entity/account_entity.dart';
import '../../../domain/entity/app_settings_entity.dart';
import '../../controller/app_settings/app_settings_cubit.dart';
import '../../controller/simple_state.dart';
import '../../controller/state_enum.dart';

import 'package:flutter/material.dart';

class PrivacyPolicyPageWidget extends StatefulWidget {
  const PrivacyPolicyPageWidget({super.key, bool? readOnly})
    : readOnly = readOnly ?? true;

  final bool readOnly;

  @override
  State<PrivacyPolicyPageWidget> createState() =>
      _PrivacyPolicyPageWidgetState();
}

class _PrivacyPolicyPageWidgetState extends State<PrivacyPolicyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _appSettingsCubit = GetIt.instance<AppSettingsCubit>();
  final _accountCubit = GetIt.instance<AccountCubit>();
  final _navigationService = GetIt.instance<INavigationService>();

  @override
  void initState() {
    super.initState();
    _appSettingsCubit.ensureAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: CustomColorTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: CustomColorTheme.primaryDarkColor,
          automaticallyImplyLeading: true,
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child:
              BlocConsumer<
                AppSettingsCubit,
                SimpleState<AppSettingsEntity, StateEnum>
              >(
                bloc: _appSettingsCubit,
                listener: (context, state) {
                  if (state.status == StateEnum.failure) {
                    return CustomSnackBar.showError(
                      context: context,
                      title: state.messageFailure,
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == StateEnum.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final appSettings = state.entity;
                  if (appSettings == null ||
                      appSettings.privacyPolicyUrl.isEmpty) {
                    return const Center(
                      child: Text('Politica de privacidade não disponíveis.'),
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                            ),
                          ),
                          child: CustomWebView(
                            url: appSettings.privacyPolicyUrl,
                          ),
                        ),
                      ),
                      if (!widget.readOnly)
                        Material(
                          color: Colors.transparent,
                          elevation: 4.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColorTheme.backgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0,
                                24.0,
                                24.0,
                                24.0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Ao clicar em \'Aceitar\', você concorda com nossa Política de Privacidade.',
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyle.bodyStyleText,
                                  ),
                                  BlocConsumer<
                                    AccountCubit,
                                    SimpleState<AccountEntity, StateEnum>
                                  >(
                                    bloc: _accountCubit,
                                    listener: (context, state) {
                                      if (state.status == StateEnum.failure) {
                                        return CustomSnackBar.showError(
                                          context: context,
                                          title: state.messageFailure,
                                        );
                                      }
                                      if (state.status == StateEnum.success) {
                                        _navigationService.pop(
                                          context: context,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return CustomButtonWidget.medium(
                                        onTap: () {
                                          _accountCubit.acceptPrivacyPolicy(
                                            version: appSettings
                                                .privacyPolicyVersion,
                                          );
                                        },
                                        title: 'Aceitar',
                                        loading:
                                            state.status == StateEnum.loading,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:base_app_clean_arch/core/design_system/components/custom_button_widget.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/design_system/components/custom_snack_bar.dart';
import '../../../core/services/launch_url/i_launch_url_service.dart';
import '../../../domain/entity/app_settings_entity.dart';
import '../../controller/app_settings/app_settings_cubit.dart';
import '../../controller/simple_state.dart';
import '../../controller/state_enum.dart';
import 'package:flutter/material.dart';

class UpdateAppPageWidget extends StatefulWidget {
  const UpdateAppPageWidget({super.key});

  @override
  State<UpdateAppPageWidget> createState() => _UpdateAppPageWidgetState();
}

class _UpdateAppPageWidgetState extends State<UpdateAppPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _appSettingsCubit = GetIt.instance<AppSettingsCubit>();
  final _launchUrlService = GetIt.instance<ILaunchUrlService>();

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
                    return const SizedBox();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox.shrink(),
                      SizedBox.shrink(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                0.0,
                                20.0,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.update,
                                    color: CustomColorTheme.primaryColor,
                                    size: 100.0,
                                  ),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 200.0,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Atualização necessária',
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.titleStyleText,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0,
                              16.0,
                              24.0,
                              16.0,
                            ),
                            child: Text(
                              'Uma nova versão do aplicativo está disponível. Atualize para continuar usando o aplicativo.',
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.bodyStyleOpactyText,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                        ),
                        child: CustomButtonWidget.medium(
                          onTap: () async {
                            if (Platform.isAndroid) {
                              await _launchUrlService.launchUrl(
                                url: appSettings.playStoreUrl,
                              );
                            } else {
                              await _launchUrlService.launchUrl(
                                url: appSettings.appStoreUrl,
                              );
                            }
                          },
                          title: 'Atualizar agora',
                        ),
                      ),
                      SizedBox.shrink(),
                      SizedBox.shrink(),
                      SizedBox.shrink(),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}

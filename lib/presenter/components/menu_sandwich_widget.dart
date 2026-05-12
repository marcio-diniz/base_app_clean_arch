import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_snack_bar.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:base_app_clean_arch/presenter/components/simple_loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/modules/inject_dependence_service.dart';
import '../../core/services/device_info/i_device_info_service.dart';
import '../../core/services/local_storage/i_local_storage_service.dart';
import '../../core/services/navigation/i_navigation_service.dart';

import '../controller/auth/sign_out_cubit.dart';
import '../controller/simple_state.dart';
import '../controller/state_enum.dart';

import 'package:flutter/material.dart';

import 'menu_sandwich_item_widget.dart';

class MenuSandwichWidget extends StatefulWidget {
  const MenuSandwichWidget({super.key});

  @override
  State<MenuSandwichWidget> createState() => _MenuSandwichWidgetState();
}

class _MenuSandwichWidgetState extends State<MenuSandwichWidget> {
  final _deviceInfoService = GetIt.instance<IDeviceInfoService>();
  final _signOutCubit = GetIt.instance<SignOutCubit>();
  final _authManager = GetIt.instance<IAuthManager>();
  final _navigationService = GetIt.instance<INavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      decoration: BoxDecoration(
        color: CustomColorTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      25.0,
                      10.0,
                      0.0,
                      8.0,
                    ),
                    child: Text(
                      'MENU',
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.bodyStyleText,
                    ),
                  ),
                  const Divider(thickness: 1.0, color: Color(0xFFE0E3E7)),
                  MenuSandwichItemWidget(
                    key: const Key('menu_sandwich_support_item'),
                    title: 'Suporte',
                    icon: Icon(
                      Icons.support_agent,
                      color: CustomColorTheme.primaryColor,
                      size: 28.0,
                    ),
                    onTap: () {
                      _navigationService.pushNamed(
                        name: 'SupportPage',
                        context: context,
                      );
                      Navigator.pop(context);
                    },
                  ),
                  MenuSandwichItemWidget(
                    title: 'Ver Termos de Uso',
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: CustomColorTheme.primaryColor,
                      size: 28.0,
                    ),
                    onTap: () {
                      _navigationService.pushNamed(
                        name: 'TermsAndConditionsPage',
                        context: context,
                        queryParameters: {'readOnly': true.toString()},
                      );

                      Navigator.pop(context);
                    },
                  ),
                  MenuSandwichItemWidget(
                    title: 'Ver Política de Privacidade',
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: CustomColorTheme.primaryColor,
                      size: 28.0,
                    ),
                    onTap: () {
                      _navigationService.pushNamed(
                        name: 'PrivacyPolicyPage',
                        context: context,
                        queryParameters: {'readOnly': true.toString()},
                      );

                      Navigator.pop(context);
                    },
                  ),
                  BlocConsumer<SignOutCubit, SimpleState<void, StateEnum>>(
                    bloc: _signOutCubit,
                    listener: (context, state) async {
                      if (state.status == StateEnum.failure) {
                        CustomSnackBar.showError(
                          context: context,
                          title: state.messageFailure,
                        );
                      }
                      if (state.status == StateEnum.success) {
                        _authManager.setEnableBiometrics(enable: false);
                        await InjectDependenceService().recreateDependences();
                        await GetIt.instance<ILocalStorageService>().clearAll();
                        await _authManager.signOut();
                        _navigationService.goNamed(name: 'auth_Login');
                      }
                    },
                    builder: (context, state) {
                      if (state.status == StateEnum.loading) {
                        return const SimpleLoadingWidget();
                      }
                      return MenuSandwichItemWidget(
                        title: 'Sair',
                        icon: Icon(
                          Icons.logout,
                          color: CustomColorTheme.primaryColor,
                          size: 28.0,
                        ),
                        onTap: () async {
                          _signOutCubit.signOut();
                        },
                      );
                    },
                  ),
                ],
              ),
              FutureBuilder<String>(
                future: _deviceInfoService.getAppVersionName(),
                builder: (context, version) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Versão do app: v${version.data}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

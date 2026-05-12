import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_button_widget.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_snack_bar.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/forgot_password_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/simple_state.dart';
import 'package:base_app_clean_arch/presenter/controller/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/design_system/components/custom_text_form_field.dart';
import '../../../../core/services/navigation/i_navigation_service.dart';

import 'package:flutter/material.dart';

class AuthForgotPasswordWidget extends StatefulWidget {
  const AuthForgotPasswordWidget({super.key});

  @override
  State<AuthForgotPasswordWidget> createState() =>
      _AuthForgotPasswordWidgetState();
}

class _AuthForgotPasswordWidgetState extends State<AuthForgotPasswordWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String countryCode = '+55';
  final phoneMask = MaskTextInputFormatter(mask: '(##)#####-####');
  final phoneTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _forgotPasswordCubit = GetIt.instance<ForgotPasswordCubit>();
  final _customAuthManager = GetIt.instance<IAuthManager>();
  final _navigationService = GetIt.instance<INavigationService>();

  @override
  void initState() {
    super.initState();
    phoneTextController.value = phoneMask.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: _customAuthManager.phoneNumber ?? ''),
    );
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: CustomColorTheme.primaryTextColor,
                          size: 30.0,
                        ),
                      ),
                      onTap: () async {
                        _navigationService.safePop(context: context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Esqueceu a senha?',
                          style: CustomTextStyle.bigTitleStyleText,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 30),
                          child: Text(
                            'Coloque seu número de telefone',
                            style: CustomTextStyle.bodyStyleText,
                          ),
                        ),
                        Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    countryCode,
                                    style: CustomTextStyle.bodyStyleText,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextFormField(
                                  controller: phoneTextController,
                                  labelText: 'Telefone',
                                  backgroundColor: Colors.white,
                                  context: context,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [phoneMask],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório.';
                                    }

                                    if (value.length < 13) {
                                      return 'Necessário número completo com DDD';
                                    }
                                    if (value.length > 14) {
                                      return 'Número de caractéres excedido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        BlocConsumer<
                          ForgotPasswordCubit,
                          SimpleState<void, StateEnum>
                        >(
                          bloc: _forgotPasswordCubit,
                          listener: (context, state) {
                            if (state.status == StateEnum.failure) {
                              CustomSnackBar.showError(
                                context: context,
                                title: state.messageFailure,
                              );
                            }
                            if (state.status == StateEnum.success) {
                              _navigationService.pushNamed(
                                name: 'auth_ChangePassword',
                                context: context,
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomButtonWidget.medium(
                              title: 'Enviar código SMS',
                              loading: state.status == StateEnum.loading,
                              onTap: () {
                                if (formKey.currentState == null ||
                                    !formKey.currentState!.validate()) {
                                  return;
                                }

                                _forgotPasswordCubit.forgotPassword(
                                  countryCode: countryCode,
                                  phone: phoneTextController.text,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

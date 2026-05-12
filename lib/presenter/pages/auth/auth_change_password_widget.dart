import 'package:base_app_clean_arch/core/design_system/components/custom_button_widget.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_snack_bar.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:base_app_clean_arch/presenter/components/auth/resend_forgot_password_code_widget.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/change_password_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/change_password_state.dart';
import 'package:base_app_clean_arch/presenter/controller/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/design_system/components/custom_text_form_field.dart';
import '../../../../core/services/navigation/i_navigation_service.dart';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthChangePasswordWidget extends StatefulWidget {
  const AuthChangePasswordWidget({super.key});

  @override
  State<AuthChangePasswordWidget> createState() =>
      _AuthChangePasswordWidgetState();
}

class _AuthChangePasswordWidgetState extends State<AuthChangePasswordWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  final pinCodeController = PinInputController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();
  final _changePasswordCubit = GetIt.instance<ChangePasswordCubit>();
  final _navigationService = GetIt.instance<INavigationService>();
  final otpLength = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0,
                      0.0,
                      16.0,
                      0.0,
                    ),
                    child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                      bloc: _changePasswordCubit,
                      listener: (context, state) {
                        if (state.status == StateEnum.failure) {
                          CustomSnackBar.showError(
                            context: context,
                            title: state.messageFailure,
                          );
                        } else if (state.status == StateEnum.success) {
                          CustomSnackBar.showSuccess(
                            context: context,
                            title: 'Senha alterada com sucesso!',
                          );
                          _navigationService.goNamed(name: 'auth_Login');
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Troque sua senha',
                              style: CustomTextStyle.bigTitleStyleText,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 30,
                              ),
                              child: Text(
                                'coloque o código recebido e defina sua nova senha',
                                style: CustomTextStyle.bodyStyleText,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 250,
                                  ),
                                  child: MaterialPinField(
                                    length: otpLength,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    autoFocus: true,
                                    hintCharacter: '-',
                                    keyboardType: TextInputType.number,
                                    pinController: pinCodeController,
                                  ),
                                ),
                              ],
                            ),
                            const ResendForgotPasswordCodeWidget(),
                            const SizedBox(height: 80),
                            CustomTextFormField(
                              controller: passwordTextController,
                              labelText: 'Senha',
                              backgroundColor: Colors.white,
                              context: context,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório.';
                                }

                                if (value.length < 8) {
                                  return 'Senha deve ter no mínimo 8 caracteres';
                                }

                                if (!RegExp(
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#=_\-\.])[A-Za-z\d@$!%*?&#=_\-\.]{8,}$',
                                ).hasMatch(value)) {
                                  return 'sua senha não segue os requisitos:\n- Deve conter uma letra maiúscula\n- Deve conter uma letra minúscula\n- Deve conter um número\n- Deve conter um caractere especial\n(@, \$, !, %, *, ?, &, #, =, _, -, .)';
                                }
                                return null;
                              },
                              obscureText: state.obscurePassword,
                              suffixIcon: InkWell(
                                onTap:
                                    _changePasswordCubit.toggleObscurePassword,
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: CustomColorTheme.secondTextColor,
                                  size: 24.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: passwordConfirmTextController,
                              labelText: 'Confirmar Senha',
                              backgroundColor: Colors.white,
                              context: context,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório.';
                                }

                                if (value != passwordTextController.text) {
                                  return 'A senha e a confirmação devem ser iguais.';
                                }

                                return null;
                              },
                              obscureText: state.obscureConfirmPassword,
                              suffixIcon: InkWell(
                                onTap: _changePasswordCubit
                                    .toggleObscureConfirmPassword,
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  state.obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: CustomColorTheme.secondTextColor,
                                  size: 24.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            CustomButtonWidget.medium(
                              onTap: () {
                                if (formKey.currentState == null ||
                                    !formKey.currentState!.validate()) {
                                  return;
                                }
                                _changePasswordCubit.changePassword(
                                  confirmationCode: pinCodeController.text,
                                  password: passwordTextController.text,
                                );
                              },
                              loading: state.status == StateEnum.loading,
                              title: 'Trocar Senha',
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:base_app_clean_arch/core/services/navigation/i_navigation_service.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/sign_in_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/design_system/components/custom_button_widget.dart';
import '../../../core/design_system/components/custom_snack_bar.dart';
import '../../../core/design_system/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthLoginWidget extends StatefulWidget {
  const AuthLoginWidget({super.key});

  @override
  State<AuthLoginWidget> createState() => _AuthLoginWidgetState();
}

class _AuthLoginWidgetState extends State<AuthLoginWidget> {
  final _signInCubit = GetIt.instance<SignInCubit>();
  final _customAuthManager = GetIt.instance<IAuthManager>();
  final _navigationService = GetIt.instance<INavigationService>();

  GlobalKey<FormState> formKey = GlobalKey();

  final phoneTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final phoneMask = MaskTextInputFormatter(mask: '(##)#####-####');
  final countryCode = '+55';

  @override
  void initState() {
    super.initState();
    _signInCubit.init();
    phoneTextController.value = phoneMask.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: _customAuthManager.phoneNumber ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: CustomColorTheme.backgroundColor,
          body: SafeArea(
            top: true,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              constraints: const BoxConstraints(maxWidth: 570.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              alignment: const AlignmentDirectional(0.0, -1.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: BlocConsumer<SignInCubit, SignInState>(
                    bloc: _signInCubit,
                    listener: (context, state) async {
                      if (state.status == SignInStateStatus.failure) {
                        CustomSnackBar.showError(
                          context: context,
                          title: state.messageFailure,
                        );
                      }
                      if (state.status ==
                          SignInStateStatus.phoneOrPasswordFailure) {
                        CustomSnackBar.showError(
                          context: context,
                          title: state.messageFailure,
                        );
                      }
                      if (state.status == SignInStateStatus.success) {
                        _navigationService.goNamed(name: 'HomePage');
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Login',
                                  style: CustomTextStyle.bigTitleStyleText,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    4.0,
                                    0.0,
                                    24.0,
                                  ),
                                  child: Text(
                                    'Preencha os campos para entrar',
                                    style: CustomTextStyle.bodyStyleText,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        key: const Key('login_phone_input'),
                                        controller: phoneTextController,
                                        labelText: 'Telefone',
                                        keyboardType: TextInputType.phone,
                                        backgroundColor: Colors.white,
                                        context: context,
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
                                const SizedBox(height: 15),
                                CustomTextFormField(
                                  key: const Key('login_password_input'),
                                  controller: passwordTextController,
                                  labelText: 'Senha',
                                  backgroundColor: Colors.white,
                                  context: context,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório.';
                                    }

                                    if (value.length < 8) {
                                      return 'Sua senha tem no mínimo 8 caracteres';
                                    }

                                    return null;
                                  },
                                  obscureText: state.obscurePassword,
                                  suffixIcon: InkWell(
                                    onTap: _signInCubit.toggleObscurePassword,
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    20.0,
                                    0.0,
                                    16.0,
                                  ),
                                  child: CustomButtonWidget.medium(
                                    key: const Key('login_submit_button'),
                                    title: 'Entrar',
                                    loading:
                                        state.status ==
                                        SignInStateStatus.loading,
                                    onTap: () {
                                      if (!(formKey.currentState?.validate() ??
                                          false)) {
                                        return;
                                      }
                                      _signInCubit.signIn(
                                        countryCode: countryCode,
                                        phone: phoneTextController.text,
                                        password: passwordTextController.text,
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                            1.0,
                                            0.0,
                                          ),
                                          child: Switch.adaptive(
                                            value: state.enableBiometrics,
                                            onChanged: _signInCubit
                                                .setEnableBiometrics,
                                            activeColor:
                                                CustomColorTheme.primaryColor,
                                            activeTrackColor: CustomColorTheme
                                                .primaryDarkColor,
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                            1.0,
                                            0.0,
                                          ),
                                          child: Text(
                                            'Biometria',
                                            style:
                                                CustomTextStyle.bodyStyleText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    30.0,
                                    0.0,
                                    12.0,
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (Navigator.of(context).canPop()) {
                                        _navigationService.pop(
                                          context: context,
                                        );
                                      }
                                      _navigationService.pushNamed(
                                        name: 'auth_Create',
                                        context: context,
                                      );
                                    },
                                    child: Center(
                                      child: RichText(
                                        textScaler: MediaQuery.of(
                                          context,
                                        ).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Já tem uma conta pré-ativada? ',
                                            ),
                                            TextSpan(
                                              text: 'Ative agora!',
                                              style: CustomTextStyle
                                                  .bodyStyleBoldText
                                                  .copyWith(
                                                    color: CustomColorTheme
                                                        .primaryDarkColor,
                                                  ),
                                            ),
                                          ],
                                          style: CustomTextStyle.bodyStyleText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(height: 20.0, thickness: 1.0),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              20.0,
                              0.0,
                              24.0,
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _navigationService.pushNamed(
                                  name: 'auth_ForgotPassword',
                                  context: context,
                                );
                              },
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Esqueceu a senha? ',
                                      style: TextStyle(),
                                    ),
                                    TextSpan(
                                      text: 'Recupere aqui!',
                                      style: CustomTextStyle.bodyStyleBoldText
                                          .copyWith(
                                            color: CustomColorTheme
                                                .primaryDarkColor,
                                          ),
                                    ),
                                  ],
                                  style: CustomTextStyle.bodyStyleText,
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
            ),
          ),
        ),
      ),
    );
  }
}

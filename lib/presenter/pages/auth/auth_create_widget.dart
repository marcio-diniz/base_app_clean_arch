import 'package:base_app_clean_arch/core/design_system/components/custom_button_widget.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_snack_bar.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';
import 'package:base_app_clean_arch/core/services/launch_url/i_launch_url_service.dart';
import 'package:base_app_clean_arch/core/services/launch_url/launch_url_type.dart';
import 'package:base_app_clean_arch/domain/entity/app_settings_entity.dart';
import 'package:base_app_clean_arch/presenter/components/simple_loading_widget.dart';
import 'package:base_app_clean_arch/presenter/controller/app_settings/app_settings_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/sign_up_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/sign_up_state.dart';
import 'package:base_app_clean_arch/presenter/controller/simple_state.dart';
import 'package:base_app_clean_arch/presenter/controller/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/design_system/components/custom_check_box_form_field.dart';
import '../../../core/design_system/components/custom_text_form_field.dart';
import '../../../../core/services/navigation/i_navigation_service.dart';

import 'package:flutter/material.dart';

class AuthCreateWidget extends StatefulWidget {
  const AuthCreateWidget({super.key});

  @override
  State<AuthCreateWidget> createState() => _AuthCreateWidgetState();
}

class _AuthCreateWidgetState extends State<AuthCreateWidget> {
  final phoneRegisterTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();

  final _appSettingsCubit = GetIt.instance<AppSettingsCubit>();
  final _signUpCubit = GetIt.instance<SignUpCubit>();
  final _navigationService = GetIt.instance<INavigationService>();

  GlobalKey<FormState> formKey = GlobalKey();

  final countryCode = '+55';

  @override
  void initState() {
    super.initState();
    _appSettingsCubit.getAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColorTheme.backgroundColor,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
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
                          'Ativar conta',
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
                            'Preencha os campos para ativar sua conta',
                            style: CustomTextStyle.bodyStyleText,
                          ),
                        ),
                        BlocConsumer<
                          AppSettingsCubit,
                          SimpleState<AppSettingsEntity, StateEnum>
                        >(
                          bloc: _appSettingsCubit,
                          listener: (context, appSettingsState) {
                            if (appSettingsState.status == StateEnum.failure) {
                              CustomSnackBar.showError(
                                context: context,
                                title: appSettingsState.messageFailure,
                              );
                            }
                          },
                          builder: (context, appSettingsState) {
                            return BlocConsumer<SignUpCubit, SignUpState>(
                              bloc: _signUpCubit,
                              listener: (context, signUpState) {
                                switch (signUpState.status) {
                                  case SignUpStateStatus.success:
                                    return _navigationService.goNamed(
                                      name: 'HomePage',
                                    );

                                  case SignUpStateStatus.alreadyPhoneFailure:
                                    return showAlreadyPhone();

                                  case SignUpStateStatus.failure:
                                    return CustomSnackBar.showError(
                                      context: context,
                                      title: signUpState.messageFailure,
                                    );

                                  default:
                                    return;
                                }
                              },
                              builder: (context, signUpState) {
                                if (appSettingsState.status ==
                                        StateEnum.loading ||
                                    signUpState.status ==
                                        SignUpStateStatus.loading) {
                                  return const SizedBox(
                                    height: 200,
                                    child: SimpleLoadingWidget(),
                                  );
                                }

                                final appSettings = appSettingsState.entity;

                                if (appSettings == null) {
                                  return const SizedBox.shrink();
                                }
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              countryCode,
                                              style:
                                                  CustomTextStyle.bodyStyleText,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller:
                                                phoneRegisterTextController,
                                            labelText: 'Telefone',
                                            backgroundColor: Colors.white,
                                            context: context,
                                            inputFormatters: [
                                              MaskTextInputFormatter(
                                                mask: '(##)#####-####',
                                              ),
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                          return 'sua senha nao segue os requisitos:\n- Deve conter uma letra maiúscula\n- Deve conter uma letra minúscula\n- Deve conter um número\n- Deve conter um caracter especial\n(@, \$, !, %, *, ?, &, #, =, _, -, .)';
                                        }
                                        return null;
                                      },
                                      obscureText: signUpState.obscurePassword,
                                      suffixIcon: InkWell(
                                        onTap:
                                            _signUpCubit.toggleObscurePassword,
                                        focusNode: FocusNode(
                                          skipTraversal: true,
                                        ),
                                        child: Icon(
                                          signUpState.obscurePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color:
                                              CustomColorTheme.secondTextColor,
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

                                        if (value !=
                                            passwordTextController.text) {
                                          return 'A senha e a confirmação devem ser iguais.';
                                        }

                                        return null;
                                      },
                                      obscureText: signUpState.obscurePassword,
                                      suffixIcon: InkWell(
                                        onTap:
                                            _signUpCubit.toggleObscurePassword,
                                        focusNode: FocusNode(
                                          skipTraversal: true,
                                        ),
                                        child: Icon(
                                          signUpState.obscurePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color:
                                              CustomColorTheme.secondTextColor,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    CustomCheckBoxFormField(
                                      context: context,
                                      initialValue:
                                          signUpState.privacyPolicyAccepted,
                                      onChanged: (accepted) => _signUpCubit
                                          .onChangePrivacyPolicyAccepted(
                                            accepted: accepted,
                                          ),
                                      validator: (value) {
                                        if (value != true) {
                                          return 'É necessário aceitar!';
                                        }
                                        return null;
                                      },
                                      suffixContent: InkWell(
                                        onTap: () {
                                          _navigationService.pushNamed(
                                            name: 'PrivacyPolicyPage',
                                            context: context,
                                            queryParameters: {
                                              'readOnly': true.toString(),
                                            },
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Eu aceito a política de privacidade.',
                                              style:
                                                  CustomTextStyle.bodyStyleText,
                                            ),
                                            Text(
                                              'Ver documento.',
                                              style:
                                                  CustomTextStyle.bodyStyleText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomCheckBoxFormField(
                                      context: context,
                                      initialValue:
                                          signUpState.termsOfUseAccepted,
                                      onChanged: (accepted) => _signUpCubit
                                          .onChangeTermsOfUseAccepted(
                                            accepted: accepted,
                                          ),
                                      validator: (value) {
                                        if (value != true) {
                                          return 'É necessário aceitar!';
                                        }
                                        return null;
                                      },
                                      suffixContent: InkWell(
                                        onTap: () {
                                          _navigationService.pushNamed(
                                            name: 'TermsAndConditionsPage',
                                            context: context,
                                            queryParameters: {
                                              'readOnly': true.toString(),
                                            },
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Eu aceito os termos de uso.',
                                              style:
                                                  CustomTextStyle.bodyStyleText,
                                            ),
                                            Text(
                                              'Ver documento.',
                                              style:
                                                  CustomTextStyle.bodyStyleText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            20.0,
                                            0.0,
                                            16.0,
                                          ),
                                      child: CustomButtonWidget.medium(
                                        title: 'Ativar',
                                        onTap: () async {
                                          if (formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            _signUpCubit.signUp(
                                              countryCode: countryCode,
                                              phone: phoneRegisterTextController
                                                  .text,
                                              password:
                                                  passwordTextController.text,
                                              confirmPassword:
                                                  passwordConfirmTextController
                                                      .text,
                                              termsVersion:
                                                  appSettings.termsVersion,
                                              privacyPolicyVersion: appSettings
                                                  .privacyPolicyVersion,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                        // You will have to add an action on this rich text to go to your login page.
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            12.0,
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
                                _navigationService.pop(context: context);
                              }
                              _navigationService.pushNamed(
                                name: 'auth_Login',
                                context: context,
                              );
                            },
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Já possui uma conta ativa? ',
                                    style: TextStyle(),
                                  ),
                                  TextSpan(
                                    text: 'Fazer Login',
                                    style: CustomTextStyle.bodyStyleBoldText
                                        .copyWith(
                                          color:
                                              CustomColorTheme.primaryDarkColor,
                                        ),
                                  ),
                                ],
                                style: CustomTextStyle.bodyStyleText,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 20.0,
                          thickness: 1.0,
                          // color: FlutterFlowTheme.of(context).alternate,
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

  void showAlreadyPhone() async {
    return await showDialog(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: const Text('Atenção!'),
          content: const Text(
            'Esse número de telefone já está cadastrado. Prossiga para o Login!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void showNoPreActivationAlert({required String? salesPhone}) async {
    return await showDialog(
      context: context,
      builder: (alertDialogContext) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => _navigationService.pop(context: context),
                      child: const Icon(Icons.close_rounded, size: 30),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/app_launcher_icon_outline.png',
                  width: 120,
                  color: CustomColorTheme.primaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  'Quase lá!',
                  style: CustomTextStyle.bodyStyleText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Olá! Vimos que você tentou se registrar. Nosso app é uma plataforma exclusiva para clientes. \n\nPara liberar o seu acesso, o primeiro passo é falar com nosso time comercial. Eles estão prontos para te ajudar a contratar o serviço ideal para você!',
                  style: CustomTextStyle.bodyStyleText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if (salesPhone != null)
                  CustomButtonWidget.medium(
                    title: 'Contratar',
                    onTap: () async {
                      const message =
                          'Olá, gostaria de contratar a proteção ARIVI.';

                      final link =
                          'https://api.whatsapp.com/send?phone=$salesPhone&text=$message';
                      await GetIt.instance<ILaunchUrlService>().launchUrl(
                        url: link,
                        launchUrlType: LaunchUrlType.externalApp,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

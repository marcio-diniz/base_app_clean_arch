import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_snack_bar.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_text_style.dart';

import 'package:base_app_clean_arch/presenter/components/simple_loading_widget.dart';
import 'package:base_app_clean_arch/presenter/controller/auth/resend_forgot_password_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../core/design_system/components/custom_button_widget.dart';
import '../../../domain/enums/send_code_type_enum.dart';
import '../../controller/auth/resend_forgot_password_code_cubit.dart';
import '../../controller/state_enum.dart';

class ResendForgotPasswordCodeWidget extends StatefulWidget {
  const ResendForgotPasswordCodeWidget({super.key});

  @override
  State<ResendForgotPasswordCodeWidget> createState() =>
      _ResendForgotPasswordCodeWidgetState();
}

class _ResendForgotPasswordCodeWidgetState
    extends State<ResendForgotPasswordCodeWidget> {
  final cubit = GetIt.instance<ResendForgotPasswordCodeCubit>();

  @override
  void initState() {
    cubit.startEnableResendCodeTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ResendForgotPasswordCodeCubit,
      ResendForgotPasswordCodeState
    >(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == StateEnum.success) {
          CustomSnackBar.showSuccess(
            context: context,
            title: state.messageSuccess,
          );
        } else if (state.status == StateEnum.failure) {
          CustomSnackBar.showError(
            context: context,
            title: state.messageFailure,
          );
        }
      },
      builder: (context, state) {
        if (state.status == StateEnum.loading) {
          return const SimpleLoadingWidget();
        }
        return Visibility(
          visible: state.enabledResendCode,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: CustomTextStyle.bodyStyleText,
                    children: [
                      const TextSpan(text: 'aguarde'),
                      TextSpan(
                        text:
                            ' ${state.enableResendCodeInSeconds} ${state.enableResendCodeInSeconds == 1 ? 'segundo' : 'segundos'} ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColorTheme.primaryColor,
                        ),
                      ),
                      const TextSpan(text: 'para reenviar o código'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              CustomButtonWidget.medium(
                onTap: () {
                  cubit.resendForgotPasswordCode(
                    sendCodeType: SendCodeTypeEnum.sms,
                  );
                },
                title: 'Reenviar código por sms',
                suffixIcon: const FaIcon(
                  size: 20,
                  FontAwesomeIcons.message,
                  color: Colors.white,
                ),
              ),
              /* const SizedBox(height: 10),
              CustomButtonBorderWidget.medium(
                onTap: () {
                  cubit.resendForgotPasswordCode(
                    sendCodeType: SendCodeTypeEnum.phoneCall,
                  );
                },
                title: 'Reenviar código por ligação',
                suffixIcon: FaIcon(
                  size: 20,
                  FontAwesomeIcons.phone,
                  color: CustomColorTheme.primaryColor,
                ),
              ) */
            ],
          ),
        );
      },
    );
  }
}

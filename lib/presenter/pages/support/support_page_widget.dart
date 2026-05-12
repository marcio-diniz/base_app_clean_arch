import 'package:base_app_clean_arch/core/design_system/components/custom_button_border_widget.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_button_widget.dart';
import 'package:base_app_clean_arch/core/design_system/tokens/custom_color_theme.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_dropdown_form_field.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_snack_bar.dart';
import 'package:base_app_clean_arch/core/design_system/components/custom_text_form_field.dart';
import 'package:base_app_clean_arch/presenter/controller/app_settings/app_settings_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/simple_state.dart';
import 'package:base_app_clean_arch/presenter/controller/state_enum.dart';
import 'package:base_app_clean_arch/presenter/controller/support/open_support_ticket_cubit.dart';
import 'package:base_app_clean_arch/presenter/controller/support/open_support_ticket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/launch_url/i_launch_url_service.dart';
import '../../../../core/services/navigation/i_navigation_service.dart';
import '../../../../domain/entity/app_settings_entity.dart';
import '../../../../domain/enums/support_subject_enum.dart';
import 'package:flutter/material.dart';

import '../../../core/design_system/tokens/custom_text_style.dart';

class SupportPageWidget extends StatefulWidget {
  const SupportPageWidget({super.key});

  @override
  State<SupportPageWidget> createState() => _SupportPageWidgetState();
}

class _SupportPageWidgetState extends State<SupportPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _appSettingsCubit = GetIt.instance<AppSettingsCubit>();
  final _openSupportTicketCubit = GetIt.instance<OpenSupportTicketCubit>();
  final _navigationService = GetIt.instance<INavigationService>();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<SupportSubjectEnum>> get optionsItems =>
      SupportSubjectEnum.values
          .map(
            (option) => DropdownMenuItem(
              key: Key(option.name),
              value: option,
              child: Text(option.subjectText),
            ),
          )
          .toList();

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
          automaticallyImplyLeading: false,
          actions: const [],
          elevation: 0.0,
          title: Text('Suporte', style: CustomTextStyle.appBarStyleText),
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onTap: () async {
              _navigationService.pop(context: context);
            },
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    alignment: const AlignmentDirectional(1.0, 1.0),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 200.0,
                          // height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Icon(
                        Icons.support_agent,
                        color: CustomColorTheme.primaryColor,
                        size: 40.0,
                      ),
                    ],
                  ),
                  Text(
                    'Preencha os campos para abrir um chamado no suporte, retornaremos assim que possível.',
                    style: CustomTextStyle.bodyStyleText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50.0),
                  BlocConsumer<OpenSupportTicketCubit, OpenSupportTicketState>(
                    bloc: _openSupportTicketCubit,
                    listener: (context, state) {
                      if (state.status == StateEnum.failure) {
                        CustomSnackBar.showError(
                          context: context,
                          title: state.messageFailure,
                        );
                      } else if (state.status == StateEnum.success) {
                        _navigationService.safePop(context: context);
                        CustomSnackBar.showSuccess(
                          context: context,
                          title:
                              'Chamado aberto com sucesso, retornaremos em breve.',
                        );
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomDropdownFormField<SupportSubjectEnum>(
                              key: const Key('support_ticket_subject_dropdown'),
                              context: context,
                              items: optionsItems,
                              value: state.subject,
                              hintText: 'Selecione o assunto',
                              backgroundColor: Colors.white,
                              onChanged:
                                  _openSupportTicketCubit.onChangedSubject,
                              validator: (val) {
                                if (val == null) {
                                  return 'Campo obrigatório.';
                                }
                                return null;
                              },
                            ),
                            Visibility(
                              visible:
                                  state.subject ==
                                  SupportSubjectEnum.deleteAccount,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'AVISO: A exclusão da sua conta será revisada pelo nosso time de suporte e executada em até 7 dias úteis. Quando o processamento for concluído, enviaremos um e-mail confirmando a exclusão da conta.',
                                        style: CustomTextStyle.bodyStyleText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              key: const Key('support_ticket_title_input'),
                              context: context,
                              labelText: 'Título',
                              hintText: 'Título do chamado (opcional)',
                              controller: titleTextController,
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              key: const Key(
                                'support_ticket_description_input',
                              ),
                              context: context,
                              labelText: 'Descrição',
                              hintText: 'Descreva o motivo do chamado',
                              maxLines: 12,
                              minLines: 3,
                              controller: descriptionTextController,
                              backgroundColor: Colors.white,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Campo obrigatório.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 50.0),
                            CustomButtonWidget.medium(
                              key: const Key('support_ticket_submit_button'),
                              loading: state.status == StateEnum.loading,
                              onTap: () {
                                if (formKey.currentState == null ||
                                    !formKey.currentState!.validate()) {
                                  return;
                                }
                                _openSupportTicketCubit.openTicket(
                                  title: titleTextController.text,
                                  description: descriptionTextController.text,
                                );
                              },
                              title: 'Enviar',
                            ),
                            const SizedBox(height: 10.0),
                            BlocBuilder<
                              AppSettingsCubit,
                              SimpleState<AppSettingsEntity, StateEnum>
                            >(
                              bloc: _appSettingsCubit,
                              builder: (context, state) {
                                final url = state.entity?.supportUrl;
                                if (url == null || url.isEmpty) {
                                  return const SizedBox.shrink();
                                }

                                return CustomButtonBorderWidget.medium(
                                  onTap: () =>
                                      GetIt.instance<ILaunchUrlService>()
                                          .launchUrl(url: url),
                                  title: 'Conversar pelo WhatsApp',
                                  suffixIcon: const FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 20,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
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

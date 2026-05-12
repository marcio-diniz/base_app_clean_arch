import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/support_subject_enum.dart';
import '../../../domain/usecase/support/i_open_support_ticket_use_case.dart';
import '../state_enum.dart';
import 'open_support_ticket_state.dart';

class OpenSupportTicketCubit extends Cubit<OpenSupportTicketState> {
  OpenSupportTicketCubit({
    required IOpenSupportTicketUseCase openSupportTicketUseCase,
  })  : _openSupportTicketUseCase = openSupportTicketUseCase,
        super(const OpenSupportTicketState.initial());

  final IOpenSupportTicketUseCase _openSupportTicketUseCase;

  Future<void> openTicket({
    required String title,
    required String description,
  }) async {
    if (state.subject == null) {
      emit(state.copyWith(
        status: StateEnum.failure,
        messageFailure: 'Selecione um assunto',
      ));
      return;
    }

    emit(state.copyWith(status: StateEnum.loading));

    String subject = state.subject!.subjectText;
    if (title.isNotEmpty) {
      subject += ' - $title';
    }

    final either = await _openSupportTicketUseCase(
      subject: subject,
      description: description,
    );
    either.fold((failure) {
      emit(state.copyWith(
        status: StateEnum.failure,
        messageFailure: failure.message,
      ));
    }, (success) {
      emit(state.copyWith(status: StateEnum.success));
    });
  }

  void onChangedSubject(SupportSubjectEnum? subject) {
    emit(state.copyWith(
      status: StateEnum.initial,
      subject: subject,
    ));
  }
}

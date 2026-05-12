import 'package:equatable/equatable.dart';

import '../../../domain/enums/support_subject_enum.dart';
import '../state_enum.dart';

class OpenSupportTicketState extends Equatable {
  const OpenSupportTicketState._({
    this.subject,
    this.messageFailure,
    required this.status,
  });

  final SupportSubjectEnum? subject;
  final String? messageFailure;
  final StateEnum status;

  const OpenSupportTicketState.initial()
      : this._(
          status: StateEnum.initial,
        );

  @override
  List<Object?> get props => [
        subject,
        messageFailure,
        status,
      ];

  OpenSupportTicketState copyWith({
    SupportSubjectEnum? subject,
    String? messageFailure,
    required StateEnum status,
  }) =>
      OpenSupportTicketState._(
        status: status,
        subject: subject ?? this.subject,
        messageFailure: messageFailure,
      );
}

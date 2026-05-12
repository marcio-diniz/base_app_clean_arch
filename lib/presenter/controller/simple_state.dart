import 'package:equatable/equatable.dart';

class SimpleState<T, E extends Enum> extends Equatable {
  const SimpleState._({
    this.entity,
    this.messageFailure,
    required this.status,
  });

  final T? entity;
  final String? messageFailure;
  final E status;

  const SimpleState.initial(E initialStatus)
      : this._(
          status: initialStatus,
        );

  @override
  List<Object?> get props => [
        entity,
        messageFailure,
        status,
      ];

  SimpleState<T, E> copyWith({
    T? entity,
    String? messageFailure,
    required E status,
  }) =>
      SimpleState<T, E>._(
        status: status,
        entity: entity ?? this.entity,
        messageFailure: messageFailure,
      );
}

import 'package:equatable/equatable.dart';

class ListState<T, E extends Enum> extends Equatable {
  const ListState._({
    required this.list,
    this.page = 1,
    this.hasMore = false,
    this.messageFailure,
    required this.status,
  });

  final List<T> list;
  final int page;
  final bool hasMore;
  final String? messageFailure;
  final E status;

  ListState.initial(E initialStatus)
      : this._(status: initialStatus, list: <T>[]);

  @override
  List<Object?> get props => [
        list,
        page,
        hasMore,
        messageFailure,
        status,
      ];

  ListState<T, E> copyWith({
    List<T>? list,
    int? page,
    bool? hasMore,
    String? messageFailure,
    required E status,
  }) =>
      ListState<T, E>._(
        status: status,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        list: list ?? this.list,
        messageFailure: messageFailure,
      );
}

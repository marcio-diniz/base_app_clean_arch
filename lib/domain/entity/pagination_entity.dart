import 'package:equatable/equatable.dart';

import 'entity.dart';

class PaginationEntity<T extends Entity> extends Equatable {
  final List<T> items;
  final String? nextToken;

  const PaginationEntity({required this.items, required this.nextToken});

  @override
  List<Object?> get props => [items, nextToken];

  bool get hasMore => nextToken?.isNotEmpty ?? false;

  PaginationEntity copyWith({List<T>? items, String? nextToken}) =>
      PaginationEntity(
        items: items ?? this.items,
        nextToken: nextToken ?? this.nextToken,
      );
}

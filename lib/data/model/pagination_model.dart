import 'package:equatable/equatable.dart';

import 'model.dart';

class PaginationModel<T extends Model> extends Equatable {
  final List<T> items;
  final String? nextToken;
  const PaginationModel({required this.items, required this.nextToken});

  @override
  List<Object?> get props => [items, nextToken];

  factory PaginationModel.fromMap({
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromMap,
  }) {
    return PaginationModel(
      items: (data['items'] as List)
          .map((element) => fromMap(element))
          .toList(),
      nextToken: data['next_token'] as String? ?? data['nextToken'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((element) => element.toMap()).toList(),
      'next_token': nextToken,
    };
  }
}

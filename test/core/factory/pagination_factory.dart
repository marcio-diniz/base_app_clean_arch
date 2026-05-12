import 'package:base_app_clean_arch/data/model/model.dart';
import 'package:base_app_clean_arch/data/model/pagination_model.dart';
import 'package:base_app_clean_arch/domain/entity/entity.dart';
import 'package:base_app_clean_arch/domain/entity/pagination_entity.dart';

class PaginationFactory {
  final String nextToken = 'next_token';

  PaginationEntity<T> createEntity<T extends Entity>({
    required T Function() createItem,
  }) {
    return PaginationEntity<T>(
      items: List.generate(2, (_) => createItem()),
      nextToken: null,
    );
  }

  PaginationModel<T> createModel<T extends Model>({
    required T Function() createItem,
  }) {
    return PaginationModel<T>(
      items: List.generate(2, (_) => createItem()),
      nextToken: null,
    );
  }

  Map<String, dynamic> createMap({
    required Map<String, dynamic> Function() createItem,
  }) {
    return {
      'items': List.generate(2, (_) => createItem()),
      'next_token': nextToken,
    };
  }
}

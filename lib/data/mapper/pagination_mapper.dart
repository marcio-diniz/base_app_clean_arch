import '../../domain/entity/entity.dart';
import '../../domain/entity/pagination_entity.dart';
import '../model/model.dart';
import '../model/pagination_model.dart';

extension PaginationModelToEntityMapper<T extends Model> on PaginationModel<T> {
  PaginationEntity<E> toPaginationEntity<E extends Entity>({
    required E Function(T model) toEntity,
  }) {
    return PaginationEntity(
      items: items.map((model) => toEntity(model)).toList(),
      nextToken: nextToken,
    );
  }
}

extension PaginationEntityToModelMapper<T extends Entity>
    on PaginationEntity<T> {
  PaginationModel<E> toPaginationModel<E extends Model>({
    required E Function(T entity) toModel,
  }) {
    return PaginationModel(
      items: items.map((entity) => toModel(entity)).toList(),
      nextToken: nextToken,
    );
  }
}

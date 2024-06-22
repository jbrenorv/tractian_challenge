abstract class Mapper<M, E> {
  M toModel(E entity);

  E toEntity(M model);

  List<M> toModelList(List<E> entities) => entities.map(toModel).toList();

  List<E> toEntityList(List<M> models) => models.map(toEntity).toList();
}

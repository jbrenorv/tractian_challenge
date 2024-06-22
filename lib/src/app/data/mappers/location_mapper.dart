import '../../../shared/mapper/mapper.dart';
import '../../domain/entities/location_entity.dart';
import '../models/location_model.dart';

class LocationMapper extends Mapper<LocationModel, LocationEntity> {
  @override
  LocationEntity toEntity(LocationModel model) {
    return LocationEntity(
      id: model.id,
      name: model.name,
      parentId: model.parentId,
    );
  }

  @override
  LocationModel toModel(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId,
    );
  }
}

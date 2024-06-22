import '../../../shared/mapper/mapper.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/enums/component_sensor_type.dart';
import '../../domain/enums/component_status.dart';
import '../models/asset_model.dart';

class AssetMapper extends Mapper<AssetModel, AssetEntity> {
  @override
  AssetEntity toEntity(AssetModel model) {
    return AssetEntity(
      id: model.id,
      name: model.name,
      gatewayId: model.gatewayId,
      locationId: model.locationId,
      parentId: model.parentId,
      sensorId: model.sensorId,
      sensorType: model.sensorType == null ? null : ComponentSensorType.create(model.sensorType!),
      status: model.status == null ? null : ComponentStatus.create(model.status!),
    );
  }

  @override
  AssetModel toModel(AssetEntity entity) {
    return AssetModel(
      id: entity.id,
      name: entity.name,
      gatewayId: entity.gatewayId,
      locationId: entity.locationId,
      parentId: entity.parentId,
      sensorId: entity.sensorId,
      sensorType: entity.sensorType?.name,
      status: entity.status?.name,
    );
  }
}

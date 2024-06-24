import 'package:equatable/equatable.dart';

import '../../../shared/utils/utils.dart';
import '../enums/component_sensor_type.dart';
import '../enums/component_status.dart';

class AssetEntity extends Equatable {
  final String id;
  final String name;

  final String? parentId;
  final String? sensorId;
  final String? gatewayId;
  final String? locationId;

  final ComponentSensorType? sensorType;
  final ComponentStatus? status;

  const AssetEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.gatewayId,
    this.locationId,
    this.sensorType,
    this.status,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    parentId,
    sensorId,
    gatewayId,
    locationId,
    sensorType,
    status,
  ];

  @override
  String toString() => getValueOrEmpty(
    props.reduce(
      (a, b) => getValueOrEmpty(a) + getValueOrEmpty(b),
    ),
  );
}

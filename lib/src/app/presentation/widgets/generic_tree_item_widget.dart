import 'package:flutter/material.dart';

import '../../../shared/icons/custom_icons.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/enums/component_sensor_type.dart';
import '../../domain/enums/component_status.dart';

class GenericTreeItemWidget extends StatelessWidget {
  const GenericTreeItemWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {

    IconData iconData = CustomIcons.location;

    ComponentStatus? componentStatus;
    ComponentSensorType? componentSensorType;

    if (data is AssetEntity) {
      if (data.sensorType != null) {
        iconData = CustomIcons.component;
        componentStatus = data.status;
        componentSensorType = data.sensorType;
      }
      else {
        iconData = CustomIcons.asset;
      }
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(
            iconData,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Expanded(
          child: Text(
            data.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (componentSensorType == ComponentSensorType.energy)
          const Icon(
            Icons.bolt,
            color: Color(0xFF52C41A),
          ),
        if (componentStatus == ComponentStatus.alert)
          const Icon(
            Icons.circle,
            color: Color(0xFFED3833),
            size: 16.0,
          ),
      ],
    );
  }
}

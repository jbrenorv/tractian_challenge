import 'dart:convert';

import 'package:equatable/equatable.dart';

class AssetModel extends Equatable {
  const AssetModel({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.gatewayId,
    this.locationId,
    this.sensorType,
    this.status,
  });

  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? gatewayId;
  final String? locationId;
  final String? sensorType;
  final String? status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
      'sensorId': sensorId,
      'gatewayId': gatewayId,
      'locationId': locationId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
      sensorId: map['sensorId'],
      gatewayId: map['gatewayId'],
      locationId: map['locationId'],
      sensorType: map['sensorType'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetModel.fromJson(String source) => AssetModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id];
}

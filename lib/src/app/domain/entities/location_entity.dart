import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String name;
  final String? parentId;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.parentId,
  });

  @override
  List<Object?> get props => [id];
}

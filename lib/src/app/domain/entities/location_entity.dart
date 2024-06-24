import 'package:equatable/equatable.dart';

import '../../../shared/utils/utils.dart';

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
  List<Object?> get props => [
    id,
    name,
    parentId,
  ];

  @override
  String toString() => getValueOrEmpty(
    props.reduce(
      (a, b) => getValueOrEmpty(a) + getValueOrEmpty(b),
    ),
  );
}

import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String id;
  final String name;

  const CompanyEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];
}

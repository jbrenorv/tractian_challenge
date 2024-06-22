import '../../../shared/mapper/mapper.dart';
import '../../domain/entities/company_entity.dart';
import '../models/company_model.dart';

class CompanyMapper extends Mapper<CompanyModel, CompanyEntity> {
  @override
  CompanyEntity toEntity(CompanyModel model) {
    return CompanyEntity(
      id: model.id,
      name: model.name,
    );
  }

  @override
  CompanyModel toModel(CompanyEntity entity) {
    return CompanyModel(
      id: entity.id,
      name: entity.name,
    );
  }
}

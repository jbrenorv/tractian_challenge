import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../shared/environment/environment.dart';
import '../../../shared/mapper/mapper.dart';
import '../../data/datasources/assets_datasorce_impl.dart';
import '../../data/datasources/assets_datasource.dart';
import '../../data/mappers/asset_mapper.dart';
import '../../data/mappers/company_mapper.dart';
import '../../data/mappers/location_mapper.dart';
import '../../data/models/asset_model.dart';
import '../../data/models/company_model.dart';
import '../../data/models/location_model.dart';
import '../../data/repositories/assets_repository_impl.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/company_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/assets_repository.dart';
import '../controllers/assets_tree_controller.dart';
import '../controllers/companies_list_controller.dart';

class AppDi implements Bindings {
  
  @override
  void dependencies() {
    Get.put<Client>(Client());

    Get.put<AssetsDatasource>(
      AssetsDatasorceImpl(
        Environment.apiBaseUrl,
        Get.find<Client>(),
      ),
    );
    
    Get.put<Mapper<AssetModel, AssetEntity>>(AssetMapper());
    Get.put<Mapper<CompanyModel, CompanyEntity>>(CompanyMapper());
    Get.put<Mapper<LocationModel, LocationEntity>>(LocationMapper());

    Get.put<AssetsRepository>(
      AssetsRepositoryImpl(
        Get.find<AssetsDatasource>(),
        Get.find<Mapper<AssetModel, AssetEntity>>(),
        Get.find<Mapper<CompanyModel, CompanyEntity>>(),
        Get.find<Mapper<LocationModel, LocationEntity>>(),
      ),
    );

    Get.put<CompaniesListController>(
      CompaniesListController(
        Get.find<AssetsRepository>(),
      ),
    );

    Get.put<AssetsTreeController>(
      AssetsTreeController(
        Get.find<AssetsRepository>(),
      ),
    );
  }
}

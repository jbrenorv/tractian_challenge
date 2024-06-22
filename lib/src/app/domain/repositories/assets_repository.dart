import 'package:result_dart/result_dart.dart';

import '../entities/asset_entity.dart';
import '../entities/company_entity.dart';
import '../entities/location_entity.dart';

abstract class AssetsRepository {
  AsyncResult<List<CompanyEntity>, Exception> getCompanies();
  AsyncResult<List<LocationEntity>, Exception> getLocations(String companyId);
  AsyncResult<List<AssetEntity>, Exception> getAssets(String companyId);
}

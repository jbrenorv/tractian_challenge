import 'package:result_dart/result_dart.dart';

import '../models/asset_model.dart';
import '../models/company_model.dart';
import '../models/location_model.dart';

abstract class AssetsDatasource {
  AsyncResult<List<CompanyModel>, Exception> getCompanies();
  AsyncResult<List<LocationModel>, Exception> getLocations(String companyId);
  AsyncResult<List<AssetModel>, Exception> getAssets(String companyId);
}

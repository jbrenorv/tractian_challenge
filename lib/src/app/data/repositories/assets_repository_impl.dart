import 'package:result_dart/result_dart.dart';

import '../../../shared/mapper/mapper.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/company_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/assets_repository.dart';
import '../datasources/assets_datasource.dart';
import '../models/asset_model.dart';
import '../models/company_model.dart';
import '../models/location_model.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  const AssetsRepositoryImpl(
    this._datasource,
    this._assetMapper,
    this._companyMapper,
    this._locationMapper,
  );

  final AssetsDatasource _datasource;
  final Mapper<AssetModel, AssetEntity> _assetMapper;
  final Mapper<CompanyModel, CompanyEntity> _companyMapper;
  final Mapper<LocationModel, LocationEntity> _locationMapper;

  @override
  AsyncResult<List<AssetEntity>, Exception> getAssets(String companyId) async {
    try {
      final result = await _datasource.getAssets(companyId);

      return result.flatMap(
        (assets) => Success(_assetMapper.toEntityList(assets)),
      );

    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  @override
  AsyncResult<List<CompanyEntity>, Exception> getCompanies() async {
    try {
      final result = await _datasource.getCompanies();

      return result.flatMap(
        (companies) => Success(_companyMapper.toEntityList(companies)),
      );

    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  @override
  AsyncResult<List<LocationEntity>, Exception> getLocations(String companyId) async {
    try {
      final result = await _datasource.getLocations(companyId);

      return result.flatMap(
        (locations) => Success(_locationMapper.toEntityList(locations)),
      );

    } on Exception catch (exception) {
      return Failure(exception);
    }
  }
}

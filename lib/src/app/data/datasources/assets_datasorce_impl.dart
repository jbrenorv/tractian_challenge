import 'dart:convert';

import 'package:http/http.dart';
import 'package:result_dart/result_dart.dart';

import '../models/asset_model.dart';
import '../models/company_model.dart';
import '../models/location_model.dart';
import 'assets_datasource.dart';

const kHttpResponseStatusOk = 200;

class AssetsDatasorceImpl implements AssetsDatasource {
  const AssetsDatasorceImpl(
    this._apiBaseUrl,
    this._client,
  );

  final String _apiBaseUrl;
  final Client _client;

  @override
  AsyncResult<List<AssetModel>, Exception> getAssets(String companyId) async {
    try {
      final uri = Uri.https(_apiBaseUrl, '/companies/$companyId/assets');

      final response = await _client.get(uri);

      if (response.statusCode == kHttpResponseStatusOk) {
        final assets = (jsonDecode(response.body) as List)
          .map((data) => AssetModel.fromMap(data))
          .toList();
        
        return Success(assets);
      }

      return Failure(Exception('Failed to get assets. Code: ${response.statusCode}'));

    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  @override
  AsyncResult<List<CompanyModel>, Exception> getCompanies() async {
    try {
      final uri = Uri.https(_apiBaseUrl, '/companies');

      final response = await _client.get(uri);

      if (response.statusCode == kHttpResponseStatusOk) {
        final companies = (jsonDecode(response.body) as List)
          .map((data) => CompanyModel.fromMap(data))
          .toList();
        
        return Success(companies);
      }

      return Failure(Exception('Failed to get companies. Code: ${response.statusCode}'));

    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  @override
  AsyncResult<List<LocationModel>, Exception> getLocations(String companyId) async {
    try {
      final uri = Uri.https(_apiBaseUrl, '/companies/$companyId/locations');

      final response = await _client.get(uri);

      if (response.statusCode == kHttpResponseStatusOk) {
        final locations = (jsonDecode(response.body) as List)
          .map((data) => LocationModel.fromMap(data))
          .toList();
        
        return Success(locations);
      }

      return Failure(Exception('Failed to get locations. Code: ${response.statusCode}'));

    } on Exception catch (exception) {
      return Failure(exception);
    }
  }
}

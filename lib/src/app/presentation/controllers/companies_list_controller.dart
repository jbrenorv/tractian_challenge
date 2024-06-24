import 'package:get/get.dart';

import '../../domain/entities/company_entity.dart';
import '../../domain/repositories/assets_repository.dart';

class CompaniesListController extends GetxController with StateMixin<List<CompanyEntity>> {
  CompaniesListController(this._assetsRepository);

  final AssetsRepository _assetsRepository;

  @override
  void onInit() {
    _getCompanies();

    super.onInit();
  }

  Future<void> _getCompanies() async {
    final result = await _assetsRepository.getCompanies();

    result.fold(
      (companies) {
        change(companies, status: RxStatus.success());
      },
      (exception) {
        change(null, status: RxStatus.error(exception.toString()));
      },
    );
  }
}

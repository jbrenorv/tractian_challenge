import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/constants.dart';
import '../controllers/companies_list_controller.dart';
import '../widgets/companies_list_widget.dart';
import 'assets_tree_page.dart';

class CompaniesListPage extends GetView<CompaniesListController> {
  const CompaniesListPage({super.key});
  
  static const String routeName = '/companies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.tractianLogoPngPath,
          height: 18.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.obx(
          (companies) => CompaniesListWidget(
            companies: companies!,
            onTapCompany: _onTapCompany,
          ),
          onError: (error) => Center(
            child: Text('Error $error'),
          ),
        ),
      ),
    );
  }

  void _onTapCompany(String companyId) {
    Get.toNamed('${AssetsTreePage.routeNamePrefix}/$companyId');
  }
}

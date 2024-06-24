import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app/presentation/di/app_di.dart';
import 'src/app/presentation/pages/assets_tree_page.dart';
import 'src/app/presentation/pages/companies_list_page.dart';
import 'src/shared/environment/environment.dart';
import 'src/shared/http_overrides/custom_http_overrides.dart';
import 'src/shared/theme/custom_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = CustomHttpOverrides();

  await Environment.load();
  
  runApp(const TractianCompaniesAssetsApp());
}

class TractianCompaniesAssetsApp extends StatelessWidget {
  const TractianCompaniesAssetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tractian Companies Assets App',
      debugShowCheckedModeBanner: false,
      initialRoute: CompaniesListPage.routeName,
      initialBinding: AppDi(),
      theme: customThemeData,
      getPages: [
        GetPage(
          name: CompaniesListPage.routeName,
          page: () => const CompaniesListPage(),
        ),
        GetPage(
          name: AssetsTreePage.routeName,
          page: () => const AssetsTreePage(),
        ),
      ],
    );
  }
}

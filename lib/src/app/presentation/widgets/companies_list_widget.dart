import 'package:flutter/material.dart';

import '../../domain/entities/company_entity.dart';
import 'company_card_widget.dart';

class CompaniesListWidget extends StatelessWidget {
  const CompaniesListWidget({
    super.key,
    required this.onTapCompany,
    required this.companies,
  });

  final void Function(String) onTapCompany;
  final List<CompanyEntity> companies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) =>  const SizedBox(height: 16.0),
      itemCount: companies.length,
      itemBuilder: (context, index) => CompanyCardWidget(
        company: companies[index],
        onTap: onTapCompany,
      ),
    );
  }
}

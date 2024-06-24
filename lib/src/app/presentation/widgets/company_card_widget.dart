import 'package:flutter/material.dart';

import '../../../shared/icons/custom_icons.dart';
import '../../domain/entities/company_entity.dart';

class CompanyCardWidget extends StatelessWidget {
  const CompanyCardWidget({
    super.key,
    required this.onTap,
    required this.company,
  });

  final void Function(String) onTap;
  final CompanyEntity company;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => onTap(company.id),
      icon: const Icon(CustomIcons.company),
      label: Text('${company.name} Unit'),
    );
  }
}

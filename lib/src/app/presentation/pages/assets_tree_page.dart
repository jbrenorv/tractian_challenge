import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/icons/custom_icons.dart';
import '../controllers/assets_tree_controller.dart';
import '../widgets/assets_tree_widget.dart';
import '../widgets/filter_card_widget.dart';

class AssetsTreePage extends GetView<AssetsTreeController> {
  const AssetsTreePage({super.key});

  static const String routeNamePrefix = '/assets';
  static const String companyIdParameterKey = 'companyId';
  static const String routeName = '$routeNamePrefix/:$companyIdParameterKey';

  @override
  Widget build(BuildContext context) {

    final companyId = Get.parameters[companyIdParameterKey]!;
    
    controller.initialize(companyId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller.searchInputFieldController,
                  textInputAction: TextInputAction.search,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: controller.onSearchTextChanged,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color(0xFFEAEFF3),
                    filled: true,
                    hintText: 'Buscar ativo ou local',
                    prefixIcon: Icon(CustomIcons.search),
                    isDense: true,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: FilterCardWidget(
                          onTap: controller.setFilterEnergySensors,
                          selected: controller.filterEnergySensors.value,
                          iconData: CustomIcons.energy_outlined,
                          labelText: 'Sensor de Energia',
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: FilterCardWidget(
                          onTap: controller.setFilterSensorsWithCriticalStatus,
                          selected: controller.filterSensorsWithCriticalStatus.value,
                          iconData: CustomIcons.info_circle,
                          labelText: 'Crítico',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: controller.obx(
              (assetsTree) => AssetsTreeWidget(tree: assetsTree!),
              onError: (error) => Center(
                child: Text('Error $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

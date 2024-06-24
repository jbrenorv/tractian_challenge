import 'package:flutter/material.dart';

import '../../../shared/ds/tree/tree_node.dart';
import '../../domain/entities/filter_value_entity.dart';
import 'generic_tree_item_widget.dart';

class AssetsTreeNodeWidget extends StatelessWidget {
  const AssetsTreeNodeWidget({
    super.key,
    required this.node,
  });

  final TreeNode<FilterValueEntity> node;

  @override
  Widget build(BuildContext context) {

    // Verify if this node is not filtered
    if (!node.value.filter) {
      return const SizedBox();
    }

    final assetWidget = GenericTreeItemWidget(data: node.value.value);

    if (node.children.any((child) => child.value.filter)) {
      return ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        shape: const Border(),
        title: assetWidget,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 11.0),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(0xFFDCDCDC)
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: node.children
                .map((node) => AssetsTreeNodeWidget(node: node))
                .toList(),
            ),
          ),
        ],
      );
    }

    return ListTile(
      title: assetWidget,
    );
  }
}

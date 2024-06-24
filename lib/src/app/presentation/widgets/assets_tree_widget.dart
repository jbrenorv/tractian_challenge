import 'package:flutter/material.dart';

import '../../../shared/ds/tree/tree.dart';
import '../../domain/entities/filter_value_entity.dart';
import 'assets_tree_node_widget.dart';

class AssetsTreeWidget extends StatelessWidget {
  const AssetsTreeWidget({
    super.key,
    required this.tree,
  });

  final Tree<FilterValueEntity> tree;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: tree.rootNodes.length,
        itemBuilder: (context, i) => AssetsTreeNodeWidget(
          node: tree.rootNodes[i],
        ),
      ),
    );
  }
}

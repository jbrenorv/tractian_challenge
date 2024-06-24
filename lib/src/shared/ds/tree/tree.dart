import 'tree_node.dart';

class Tree<T> {
  const Tree({this.rootNodes = const []});

  final List<TreeNode<T>> rootNodes;
}

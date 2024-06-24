class TreeNode<T> {
  TreeNode(this.value) : children = <TreeNode<T>>[];

  final T value;
  final List<TreeNode<T>> children;

  void addChild(TreeNode<T> child) => children.add(child);
}

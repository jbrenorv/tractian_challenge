class FilterValueEntity<T> {
  FilterValueEntity(
    this.value, {
    this.filter = true,
  });

  final T value;
  bool filter;

  void setFilter(bool filter) {
    this.filter = filter;
  }
}

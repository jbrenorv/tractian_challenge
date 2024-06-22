enum ComponentStatus {
  operating,
  alert;

  factory ComponentStatus.create(String? name) {
    return values.firstWhere((value) => value.name == name);
  }
}

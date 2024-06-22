enum ComponentSensorType {
  vibration,
  energy;

  factory ComponentSensorType.create(String name) {
    return values.firstWhere((value) => value.name == name);
  }
}

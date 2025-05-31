class AgeRangeModel {
  int id;
  String name;
  int value;

  AgeRangeModel({required this.id, required this.name, required this.value});

  factory AgeRangeModel.fromMap(Map<String, dynamic> map) {
    return AgeRangeModel(id: map['id'], name: map['name'], value: map['value']);
  }
}

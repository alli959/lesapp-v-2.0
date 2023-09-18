class DataModel {
  final Object model;

  const DataModel({required this.model});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      model: json['model'].toString(),
    );
  }
}


class Data {
  String Text;
  String Karl;
  String Dora;

  Data({
    required this.Text,
    required this.Karl,
    required this.Dora,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      Text: json['Text'],
      Karl: json['Karl'],
      Dora: json['Dora'],
    );
  }
}

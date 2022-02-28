import 'dart:convert';
// import 'package:projectPath/model/product.dart';
import 'package:http/http.dart' as http;

class GetData {
  String typeofgame;
  String typeofdifficulty;

  GetData(String typeofgame, String typeofdifficulty) {
    this.typeofgame = typeofgame;
    this.typeofdifficulty = typeofdifficulty;
  }

  Future<List<Object>> getProducts() async {
    var url = Uri.https(
        'www.si7jh53lg1.execute-api.eu-west-1.amazonaws.com',
        '/dev/get',
        {typeofgame: this.typeofgame, typeofdifficulty: this.typeofdifficulty});
    // var url = Uri.parse(
    //     'https://si7jh53lg1.execute-api.eu-west-1.amazonaws.com/dev/get');
    return http.get(url).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final temp = json.decode(response.body);

        return temp;
      }
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return null;
    });
  }
}

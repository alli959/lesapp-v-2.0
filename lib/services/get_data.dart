import 'dart:convert';
// import 'package:projectPath/model/product.dart';
import 'package:http/http.dart' as http;

import '../models/data.dart';
import 'dart:convert' show utf8;

class GetData {
  String typeofgame;
  String typeofdifficulty;

  GetData(String typeofgame, String typeofdifficulty) {
    this.typeofgame = typeofgame;
    this.typeofdifficulty = typeofdifficulty;
  }

  Future<List<Data>> getData() async {
    var url = Uri.https(
        'si7jh53lg1.execute-api.eu-west-1.amazonaws.com', '/dev/get', {
      "typeofgame": this.typeofgame,
      "typeofdifficulty": this.typeofdifficulty
    });
    return await http.get(url, headers: {
      "Content-Type": 'application/json',
      "charset": "utf-8"
    }).then((http.Response response) {
      print("response is ${response.body}");
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        Iterable l = json.fuse(utf8).decode(response.bodyBytes);
        List<Data> temp =
            List<Data>.from(l.map((model) => Data.fromJson(model)));
        print("temp is $temp");

        return temp;
      }
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return null;
    });
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
// import 'package:projectPath/model/product.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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

  void setData(String typeofgame, String typeofdifficutly) {
    this.typeofgame = typeofgame;
    this.typeofdifficulty = typeofdifficutly;
  }

  Future<List<Data>> getData() async {
    DefaultCacheManager().emptyCache();
    var url = Uri.https(
        '8iu5izdtgc.execute-api.eu-west-1.amazonaws.com', '/dev/get', {
      "typeofgame": this.typeofgame,
      "typeofdifficulty": this.typeofdifficulty
    });

    var fileInfo = await DefaultCacheManager()
        .getFileFromCache('${this.typeofgame}_${this.typeofdifficulty}');
    if (fileInfo == null) {
      return await http.get(url, headers: {
        "Content-Type": 'application/json',
        "charset": "utf-8"
      }).then((http.Response response) {
        print("response is ${response.body}");
        final int statusCode = response.statusCode;
        if (statusCode == 200) {
          DefaultCacheManager().putFile(url.toString(), response.bodyBytes,
              key: '${this.typeofgame}_${this.typeofgame}');
          Iterable l = json.fuse(utf8).decode(response.bodyBytes);
          List<Data> temp =
              List<Data>.from(l.map((model) => Data.fromJson(model)));
          print("temp after calling from web is $temp");

          return temp;
        }
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        return null;
      });
    } else {
      Uint8List bodyBytes = await fileInfo.file.readAsBytes();
      Iterable l = json.fuse(utf8).decode(bodyBytes);
      List<Data> temp = List<Data>.from(l.map((model) => Data.fromJson(model)));
      print("temp after calling from cache is $temp");

      return temp;
    }
  }
}

      // return await DefaultCacheManager().getSingleFile(url.toString(), headers: {
      //   "Content-Type": 'application/json',
      //   "charset": "utf-8"
      // }).then((http.Response response) {
      //   print("response is ${response.body}");
      //   final int statusCode = response.statusCode;
      //   if (statusCode == 200) {
      //     Iterable l = json.fuse(utf8).decode(response.bodyBytes);
      //     List<Data> temp =
      //         List<Data>.from(l.map((model) => Data.fromJson(model)));
      //     print("temp is $temp");

      //     return temp;
      //   }
      //   if (statusCode < 200 || statusCode > 400 || json == null) {
      //     throw new Exception("Error while fetching data");
      //   }
      //   return null;
      // });
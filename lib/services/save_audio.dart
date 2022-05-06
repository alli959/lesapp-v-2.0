import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
// import 'package:projectPath/model/product.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:simple_s3/simple_s3.dart';

import '../S3_keys.dart';
import '../models/data.dart';
import 'dart:convert' show utf8;
import 'package:uuid/uuid.dart';

class SaveAudio {
  AuthService _service;
  String username;

  /// Correct, Incorrect, Manual_Correct, Manual_Incorrect
  String typeoffile;
  String question;
  String answer;
  io.File audio;
  var uuid = Uuid();

  SaveAudio(String username, String typeoffile, String question, String answer,
      io.File audio) {
    this.username = username;
    this.typeoffile = typeoffile;
    this.question = question;
    this.answer = answer;
    this.audio = audio;
    this._service = new AuthService();
  }

  void setData(String username, String typeoffile, String question,
      String answer, io.File audio) {
    this.username = username;
    this.typeoffile = typeoffile;
    this.question = question;
    this.answer = answer;
    this.audio = audio;
  }

  SimpleS3 _simpleS3 = SimpleS3();

  Future<String> saveData() async {
    var prefix = "users/$username/$typeoffile";
    var text = "question: $question\nanswer: $answer";
    List<int> list = text.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    io.File textFile = new io.File.fromRawPath(bytes);
    var audioKey = "${prefix}";
    var textKey = "$prefix";
    var audioFilename = "test.wav";
    var textFilename = "test.txt";
    String result;
    String result2;

    if (result == null) {
      try {
        result = await _simpleS3.uploadFile(audio, Credentials.s3_bucketName,
            Credentials.s3_poolD, AWSRegions.euWest1,
            debugLog: true,
            s3FolderPath: audioKey,
            accessControl: S3AccessControl.publicRead,
            fileName: audioFilename);
      } catch (e) {
        print("error uploading audio file to s3 $e");
      }
    }
    if (result2 == null) {
      try {
        result2 = await _simpleS3.uploadFile(textFile,
            Credentials.s3_bucketName, Credentials.s3_poolD, AWSRegions.euWest1,
            debugLog: true,
            s3FolderPath: textKey,
            accessControl: S3AccessControl.bucketOwnerFullControl,
            fileName: textFilename);
      } catch (e) {
        print("error uploading audio file to s3 $e");
      }
    }
    print("result 1 is $result");
    print("result 2 is $result2");
    return "$result => $result2";
  }

  // Future saveData() async {
  //   var body = {
  //     "username": username,
  //     "typeoffile": typeoffile,
  //     "question": question,
  //     "answer": answer,
  //     "audio": audio.toString()
  //   };
  //   String bodyString = body.toString();
  //   var token = "bearer ${await _service.getCurrentUserToken()}";
  //   var headers = {"Authorization": token};
  //   String headerString = headers.toString();

  //   print("headerString is \n $headerString");

  //   print("bodyString is $bodyString");

  //   print("usertoken is $token");
  //   var url = Uri.https(
  //       '8iu5izdtgc.execute-api.eu-west-1.amazonaws.com', '/dev/save');
  //   return await http
  //       .post(url, body: jsonEncode(body), headers: headers)
  //       .then((http.Response response) {
  //     print("response is ${response.body}");
  //     final int statusCode = response.statusCode;
  //     if (statusCode == 200) {
  //       print("The file save was successful");

  //       return;
  //     }
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return null;
  //   });
  // }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
// import 'package:projectPath/model/product.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'package:simple_s3/simple_s3.dart';

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
  Uint8List audio;
  var uuid = Uuid();

  SaveAudio(String username, String typeoffile, String question, String answer,
      Uint8List audio) {
    this.username = username;
    this.typeoffile = typeoffile;
    this.question = question;
    this.answer = answer;
    this.audio = audio;
    this._service = new AuthService();
  }

  void setData(String username, String typeoffile, String question,
      String answer, Uint8List audio) {
    this.username = username;
    this.typeoffile = typeoffile;
    this.question = question;
    this.answer = answer;
    this.audio = audio;
  }

  // Future<String> saveData() async {
  //   var prefix = "users/$username/$typeoffile";
  //   var text = "question: $question\nanswer: $answer";
  //   List<int> list = text.codeUnits;
  //   Uint8List bytes = Uint8List.fromList(list);
  //   io.File textFile = new io.File.fromRawPath(bytes);
  //   var audioKey = "${prefix}";
  //   var textKey = "$prefix";
  //   var audioFilename = "test.wav";
  //   var textFilename = "test.txt";
  //   String result;
  //   String result2;

  //   if (result == null) {
  //     try {
  //       result = await _simpleS3.uploadFile(audio, Credentials.s3_bucketName,
  //           Credentials.s3_poolD, AWSRegions.euWest1,
  //           debugLog: true,
  //           s3FolderPath: audioKey,
  //           accessControl: S3AccessControl.publicRead,
  //           fileName: audioFilename);
  //     } catch (e) {
  //       print("error uploading audio file to s3 $e");
  //     }
  //   }
  //   if (result2 == null) {
  //     try {
  //       result2 = await _simpleS3.uploadFile(textFile,
  //           Credentials.s3_bucketName, Credentials.s3_poolD, AWSRegions.euWest1,
  //           debugLog: true,
  //           s3FolderPath: textKey,
  //           accessControl: S3AccessControl.bucketOwnerFullControl,
  //           fileName: textFilename);
  //     } catch (e) {
  //       print("error uploading audio file to s3 $e");
  //     }
  //   }
  //   print("result 1 is $result");
  //   print("result 2 is $result2");
  //   return "$result => $result2";
  // }

  // Future saveData() async {
  //   var body = {
  //     "username": username,
  //     "typeoffile": typeoffile,
  //     "question": question,
  //     "answer": answer,
  //     "audio": audio.toString()
  //   };
  //   String bodyString = body.toString();
  //   var token = "bearer ${100}";
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

  Future<void> saveData() async {
    var uuid = Uuid().v1();
    var prefix = "users/$username/$typeoffile";
    var text = "question: $question\nanswer: $answer";
    final tempDir = await getTemporaryDirectory();
    final textFile = io.File(tempDir.path + '/$uuid.txt')
      ..createSync()
      ..writeAsStringSync(text, encoding: utf8);

    final audioFile = io.File(tempDir.path + '/$uuid.wav')
      ..createSync()
      ..writeAsBytesSync(audio);

    print("uuid is =====> $uuid");

    String audioName = typeoffile + '/' + uuid + '.wav';
    String textName = typeoffile + '/' + uuid + '.txt';

    final option1 = S3UploadFileOptions(
        accessLevel: StorageAccessLevel.protected, contentType: 'audio/wav');
    final option2 = S3UploadFileOptions(
        accessLevel: StorageAccessLevel.protected,
        contentType: 'text/plain; charset=utf8');
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: audioFile,
          key: audioName,
          options: option1,
          onProgress: (progress) {
            print("Fraction completed: " +
                progress.getFractionCompleted().toString());
          });
      print('Successfully uploaded audio file: ${result.key}');
    } catch (err) {
      print("failed uploading the audio file with error $err");
    }
    try {
      final UploadFileResult result2 = await Amplify.Storage.uploadFile(
          local: textFile,
          key: textName,
          options: option2,
          onProgress: (progress) {
            print("Fraction completed: " +
                progress.getFractionCompleted().toString());
          });
      print("Successfully uploaded text file ${result2.key}");
    } catch (err) {
      print("failed uploading the text file with error $err");
    }
  }
}

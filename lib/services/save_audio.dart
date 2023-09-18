import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert' show utf8;
import 'package:uuid/uuid.dart';
import 'package:aws_common/vm.dart'; // Import this for AWSFilePlatform

class SaveAudio {
  late String username;
  late String typeoffile;
  late String question;
  late String answer;
  late Uint8List? audio;
  var uuid = Uuid();

  SaveAudio(String username, String typeoffile, String question, String answer,
      Uint8List? audio) {
    this.username = username;
    this.typeoffile = typeoffile;
    this.question = question;
    this.answer = answer;
    this.audio = audio;
  }

  void setData(String username, String typeoffile, String question,
      String answer, Uint8List audio) {
    this.username = username;
    this.typeoffile = typeoffile;
    this.question = question;
    this.answer = answer;
    this.audio = audio;
  }

  Future<void> saveData() async {
    var uuid = Uuid().v1();
    var text = "question: $question\nanswer: $answer";
    final tempDir = await getTemporaryDirectory();
    final textFile = io.File(tempDir.path + '/$uuid.txt')
      ..createSync()
      ..writeAsStringSync(text, encoding: utf8);

    final audioFile = io.File(tempDir.path + '/$uuid.wav')
      ..createSync()
      ..writeAsBytesSync(audio as List<int>);

    print("uuid is =====> $uuid");

    String audioName = typeoffile + '/' + uuid + '.wav';
    String textName = typeoffile + '/' + uuid + '.txt';

    final audioOptions = StorageUploadFileOptions(
      accessLevel: StorageAccessLevel.protected,
      pluginOptions: S3UploadFilePluginOptions(),
      metadata: {'contentType': 'audio/wav'},
    );

    final textOptions = StorageUploadFileOptions(
      accessLevel: StorageAccessLevel.protected,
      pluginOptions: S3UploadFilePluginOptions(),
      metadata: {'contentType': 'text/plain; charset=utf8'},
    );

    try {
      final operation = Amplify.Storage.uploadFile(
        localFile: AWSFilePlatform.fromFile(audioFile),
        key: audioName,
        options: audioOptions,
        onProgress: (progress) {
          print("Fraction completed: ${progress.fractionCompleted}");
        },
      );
      final audioResult = await operation.result;
      print('Successfully uploaded audio file: ${audioResult}');
    } catch (err) {
      print("Failed uploading the audio file with error $err");
    }

    try {
      final operation = Amplify.Storage.uploadFile(
        localFile: AWSFilePlatform.fromFile(textFile),
        key: textName,
        options: textOptions,
        onProgress: (progress) {
          print("Fraction completed: ${progress.fractionCompleted}");
        },
      );
      final textResult = await operation.result;
      print('Successfully uploaded text file: ${textResult}');
    } catch (err) {
      print("Failed uploading the text file with error $err");
    }
  }
}

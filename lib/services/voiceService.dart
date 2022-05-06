import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:Lesaforrit/models/quiz_brain_lvlOne_voice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pbgrpc.dart'
    hide RecognitionConfig, StreamingRecognitionConfig;
import 'dart:async';

import 'package:google_speech/google_speech.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class VoiceService {
  SpeechToText speech;
  BuildContext context;
  bool hasSpeech = false;
  bool logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = ' ';
  String lastError = ' ';
  String lastStatus = ' ';
  String currentLocaleID = 'is_IS';
  dynamic localeNames = [];
  bool isListening = false;
  bool finalResult = false;
  String question = ' ';
  String nextQuestion = ' ';
  double points = 0;
  List<bool> questionMap = [];
  List<bool> answerMap = [];
  List<String> questionArr = [];
  List<String> answerArr = [];
  AudioPlayer player = AudioPlayer();
  List<Uint8List> audioList = [];

  TotalPoints calc = TotalPoints();
  List<String> base64 = [];

  QuizBrainLvlThreeVoice quizBrainLvlThree = QuizBrainLvlThreeVoice();
  QuizBrainLvlTwoVoice quizBrainLvlTwo = QuizBrainLvlTwoVoice();
  QuizBrainLvlOneVoice quizBrainLvlOne = QuizBrainLvlOneVoice();

  final RecorderStream _recorder = RecorderStream();
  PlayerStream _player = PlayerStream();
  // Stream<StreamingRecognizeResponse> responseStream;
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>> _audioStreamSubscription;
  BehaviorSubject<List<int>> _audioStream;

  RecognitionConfig config;

  VoiceService({@required this.speech, this.context});

  Future speechInit(Function statusListener, Function errorListener) async {
    config = _getConfig();

    try {
      _recorder.initialize();
      _player.initialize();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getExternalStorageDirectory(); // 1
    print("appDocumentsDirectory is $appDocumentsDirectory");
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoaudiofile.wav'; // 3

    return filePath;
  }

  File saveFile(List<Uint8List> contents, sampleRate) {
    // File recordedFile = File(await getFilePath());

    List<int> data = [];
    for (var i = 0; i < contents.length; i++) {
      try {
        data.addAll(contents[i]);
      } catch (err) {
        print("there was an error $err");
        throw err;
      }
    }

    var channels = 1;

    int byteRate = ((16 * sampleRate * channels) / 8).round();

    var size = data.length;

    var fileSize = size + 36;

    Uint8List header = Uint8List.fromList([
      // "RIFF"
      82, 73, 70, 70,
      fileSize & 0xff,
      (fileSize >> 8) & 0xff,
      (fileSize >> 16) & 0xff,
      (fileSize >> 24) & 0xff,
      // WAVE
      87, 65, 86, 69,
      // fmt
      102, 109, 116, 32,
      // fmt chunk size 16
      16, 0, 0, 0,
      // Type of format
      1, 0,
      // One channel
      channels, 0,
      // Sample rate
      sampleRate & 0xff,
      (sampleRate >> 8) & 0xff,
      (sampleRate >> 16) & 0xff,
      (sampleRate >> 24) & 0xff,
      // Byte rate
      byteRate & 0xff,
      (byteRate >> 8) & 0xff,
      (byteRate >> 16) & 0xff,
      (byteRate >> 24) & 0xff,
      // Uhm
      ((16 * channels) / 8).round(), 0,
      // bitsize
      16, 0,
      // "data"
      100, 97, 116, 97,
      size & 0xff,
      (size >> 8) & 0xff,
      (size >> 16) & 0xff,
      (size >> 24) & 0xff,
      ...data
    ]);

    File deployFile = new File.fromRawPath(header);

    // await recordedFile.writeAsBytes(header, flush: true);

    return deployFile;
  }

  // Future saveFile(List<Uint8List> contents) async {
  //   File.fromRawPath(rawPath)
  //   File file = File(await getFilePath()); // 1
  //   List<int> bytlist = [];
  //   for (var i = 0; i < contents.length; i++) {
  //     print("contents[i] is =>>>>> ${contents[i]}");
  //     try {
  //       bytlist.addAll(contents[i]);
  //     } catch (err) {
  //       print("there was an error $err");
  //       throw err;
  //     }
  //   }
  //   await file.writeAsBytes(bytlist); // 2
  // }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      maxAlternatives: 30,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'is-IS');

  Future speechListen(resultListener, Function soundLevelListener) async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      if (!_audioStream.isClosed) {
        _audioStream.add(event);
        audioList.add(event);
        _player.writeChunk(event);
      }
    });

    await _recorder.start();
    print("after recorder start");
    final responseStream = speech.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream);
    print("responseStream");
    recognizing = true;
    try {
      if (!_audioStream.isClosed) {
        responseStream.listen(resultListener,
            onDone: () => soundLevelListener(saveFile(audioList, 16000)));
      }
    } catch (err) {
      print("THERE WAS AN ERROR ${err}");
    }
  }

  Future stopRecording() async {
    // await saveFile(audioList, 16000);
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    recognizing = false;
  }

  Future reset() async {
    await stopRecording();
    lastWords = ' ';
    lastError = ' ';
    lastStatus = ' ';
    question = ' ';
    nextQuestion = ' ';
    points = 0;
    questionMap = [];
    answerMap = [];
    questionArr = [];
    answerArr = [];
    calc.correct = 0;
    calc.finalPoints = 0.0;
    calc.trys = 0;
  }

  // Future SaveFile() async {
  //   Share.file
  // }
}

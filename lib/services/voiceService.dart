import 'dart:math' as math;

import 'package:Lesaforrit/models/quiz_brain_lvlOne_voice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:flutter/material.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pbgrpc.dart'
    hide RecognitionConfig, StreamingRecognitionConfig;
import 'dart:async';

import 'package:google_speech/google_speech.dart';
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

  TotalPoints calc = TotalPoints();

  QuizBrainLvlThreeVoice quizBrainLvlThree = QuizBrainLvlThreeVoice();
  QuizBrainLvlTwoVoice quizBrainLvlTwo = QuizBrainLvlTwoVoice();
  QuizBrainLvlOneVoice quizBrainLvlOne = QuizBrainLvlOneVoice();

  final RecorderStream _recorder = RecorderStream();
  Stream<StreamingRecognizeResponse> responseStream;
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
      return true;
    } catch (err) {
      return false;
    }
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'is-IS');

  Future speechListen(resultListener, Function soundLevelListener) async {
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream.add(event);
    });
    print("_audioStreamSubscription");

    await _recorder.start();
    print("after recorder start");
    responseStream = speech?.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream);
    print("responseStream");
    recognizing = true;
    try {
      responseStream.listen((data) {
        final currentText =
            data.results.map((e) => e.alternatives.first.transcript).join('\n');

        print("currentText is $currentText");
      }, onError: resultListener);
    } catch (err) {
      print("THERE WAS AN ERROR ${err}");
    }
  }

  Future stopRecording() async {
    print("we are stopping this recording");
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    recognizing = false;
  }

  void reset() {
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
}

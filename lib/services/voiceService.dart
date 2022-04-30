import 'dart:math' as math;

import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlOne_voice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class VoiceService {
  SpeechToText speech;
  BuildContext? context;
  List<SpeechRecognitionWords> alternates = [];
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
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  RecognitionConfig? config;

  VoiceService({required this.speech, this.context});

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
      _audioStream!.add(event);
    });

    final responseStream = speech.streamingRecognize(
        StreamingRecognitionConfig(config: config!, interimResults: true),
        _audioStream!);
    await _recorder.start();
    recognizing = true;
    try {
      responseStream.listen(resultListener, onError: resultListener);
    } catch (err) {
      print("THERE WAS AN ERROR ${err}");
    }
  }

  void stopRecording() async {
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

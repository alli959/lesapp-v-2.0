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
import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText speech;
  final BuildContext context;
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

  Function onError;

  VoiceService({@required this.speech, this.context});

  Future speechInit(Function statusListener, Function errorListener) async {
    hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
      finalTimeout: Duration(milliseconds: 2000),
    );
    this.onError = onError;
    return hasSpeech;
  }

  void speechListen(Function resultListener, Function soundLevelListener) {
    try {
      speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 10),
        partialResults: true,
        localeId: 'is_IS',
        // onSoundLevelChange: soundLevelListener,
        cancelOnError: false,
        listenMode: ListenMode.confirmation,
      );
    } catch (err) {
      print("THERE WAS AN ERROR ${err}");
    }
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

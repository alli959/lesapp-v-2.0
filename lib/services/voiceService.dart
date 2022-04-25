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

  Future speechInit(Function statusListener) async {
    hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
      finalTimeout: Duration(milliseconds: 0),
    );
    this.onError = onError;
    return hasSpeech;
  }

  void speechListen(Function resultListener) {
    try {
      speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 10),
        partialResults: true,
        localeId: 'is_IS',
        onSoundLevelChange: soundLevelListener,
        cancelOnError: false,
        listenMode: ListenMode.confirmation,
      );
    } catch (err) {
      print("THERE WAS AN ERROR ${err}");
    }
  }

  void errorListener(SpeechRecognitionError error) {
    print("there was an error ${error}");
    this.onError("test");
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    lastError = '${error.errorMsg} - ${error.permanent}';
  }

  void soundLevelListener(double lvl) {
    minSoundLevel = math.min(minSoundLevel, level);
    maxSoundLevel = math.max(maxSoundLevel, level);
    level = lvl;
  }

  String displayText(lvl) {
    var question;
    if (lvl == "level_3") {
      question = quizBrainLvlThree.getQuestionText();
    }
    if (lvl == "level_2") {
      question = quizBrainLvlTwo.getQuestionText();
    }
    if (lvl == "level_1") {
      question = quizBrainLvlOne.getQuestionText();
    }
    return question;
  }

  Map<String, Object> checkAnswer(
      String userVoiceAnswer, String question, String lvl) {
    // if (quizBrain.isFinished() == true) {
    //   quizBrain.reset();
    // } else {

    if (lvl == "level_1") {
      print("question = $question");
      print("answer = $userVoiceAnswer");

      if (question[0].toLowerCase() == userVoiceAnswer[0].toLowerCase()) {
        userVoiceAnswer = question;
      }
    }

    int totalCorrect = 0;
    int totalIncorrect = 0;
    List<String> questionArr = question.split(' ');
    List<String> answerArr = userVoiceAnswer.split(' ');
    Map<String, int> mapQuestion = {};
    Map<String, int> mapAnswer = {};
    List<bool> questionMap = [];
    List<bool> answerMap = [];
    // Creating hashmap of questions
    for (var i = 0; i < questionArr.length; i++) {
      if (mapQuestion.containsKey(questionArr[i].toLowerCase())) {
        mapQuestion[questionArr[i].toLowerCase()] += 1;
      } else {
        mapQuestion[questionArr[i].toLowerCase()] = 1;
      }
    }

    // Creating hashmap of answers
    for (var i = 0; i < answerArr.length; i++) {
      if (mapAnswer.containsKey(answerArr[i].toLowerCase())) {
        mapAnswer[answerArr[i].toLowerCase()] += 1;
      } else {
        mapAnswer[answerArr[i].toLowerCase()] = 1;
      }
    }

    // Creating colorBoard for questions
    /* TODO  IF A WORD IS DUPLICATE */
    for (var i = 0; i < questionArr.length; i++) {
      if (mapAnswer.containsKey(questionArr[i].toLowerCase())) {
        questionMap.add(true);
      } else {
        questionMap.add(false);
      }
    }

    // Creating colorBoard for answers
    /* TODO  IF A WORD IS DUPLICATE */

    for (var i = 0; i < answerArr.length; i++) {
      if (mapQuestion.containsKey(answerArr[i].toLowerCase())) {
        totalCorrect += 1;
        answerMap.add(true);
      } else {
        totalIncorrect += 1;
        answerMap.add(false);
      }
    }

    // calculating points
    double points = totalCorrect / (totalCorrect + totalIncorrect);

    return {
      "points": points,
      "correct": totalCorrect,
      "questionMap": questionMap,
      "answerMap": answerMap,
      "questionArr": questionArr,
      "answerArr": answerArr
    };
    // if (userVoiceAnswer.toLowerCase() == question.toLowerCase()) {
    //   return true;
    //   // }
    // }
    // return false;
  }

  dynamic bestLastWord(String lastWords, String question,
      List<SpeechRecognitionWords> alternates) {
    print("inBestLastWordsFunction !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("${alternates}");
    print(lastWords);
    print(question);
    int closestVal = lastWords.toLowerCase().compareTo(
        question.toLowerCase()); //compare correct answer to voice input

    int closestIndex =
        -1; //index of closest value, if -1 then result.recongizedwords
    //check if alternates are closer to correct answer
    for (int i = 0; i < alternates.length; i++) {
      String tempString = alternates[i].recognizedWords;
      int temp = tempString.toLowerCase().compareTo(question.toLowerCase());
      if (temp.abs() < closestVal.abs()) {
        print("temp < closestVal");
        print("tempString: $tempString");
        print("lastWords: $lastWords");
        print("tempInt: $temp");
        print("closestValInt: $closestVal");

        closestIndex = i;
        closestVal = temp;
      }
    }

    if (closestIndex == -1) {
      return lastWords;
    } else {
      print("there was another");
      print(alternates[closestIndex].recognizedWords);

      lastWords = alternates[closestIndex].recognizedWords;

      return alternates[closestIndex].recognizedWords;
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

List<Widget> positionFinder(
    double controllerVal, double maxControllerVal, double midX, double midY) {
  List<Widget> returnVal = [];

  if (controllerVal / maxControllerVal < 0.5) {
    returnVal.add(
      Transform.rotate(
          angle: controllerVal * 2 * math.pi,
          child: Image.asset('assets/images/star.png')),
    );

    return returnVal;
  } else if (controllerVal / maxControllerVal < 0.7) {
    returnVal.add(Positioned(
        child: Image.asset('assets/images/explotion6.png'),
        width: 300,
        height: 243,
        left: midX,
        top: midY));

    return returnVal;
  }

  returnVal.add(Positioned(
      child: Image.asset('assets/images/star.png'),
      width: 300 * (controllerVal / maxControllerVal),
      height: 243 * (controllerVal / maxControllerVal),
      left: midX,
      top: midY));
  return returnVal;
}

void _logEvent(String eventDescription) {
  var eventTime = DateTime.now().toIso8601String();
  print('$eventTime $eventDescription');
  // }
}

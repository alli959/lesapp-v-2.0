import 'dart:math';

import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
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
  QuizBrainLvlThree quizBrain = QuizBrainLvlThree();

  VoiceService({@required this.speech, this.context});

  Future speechInit(statusListener) async {
    hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
      finalTimeout: Duration(milliseconds: 0),
    );
    return hasSpeech;
  }

  void speechListen(Function resultListener) {
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 30),
      pauseFor: Duration(seconds: 10),
      partialResults: true,
      localeId: 'is_IS',
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
    );
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    lastError = '${error.errorMsg} - ${error.permanent}';
  }

  // void resultListener(SpeechRecognitionResult result) {
  //   _logEvent(
  //       'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
  //   lastWords = '${result.recognizedWords}';
  //   final _voiceBloc = BlocProvider.of<VoiceBloc>(context);

  //   alternates = result.alternates;
  //   _voiceBloc
  //       .add(LastWordsEvent(lastWords: lastWords, alternates: alternates));
  //   // LastWordsEvent(
  //   //     lastWords: '${result.recognizedWords}', alternates: result.alternates);
  // }

  void soundLevelListener(double lvl) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    level = lvl;
  }

  // void statusListener(String status) {
  //   _logEvent(
  //       'Received listener status: $status, listening: ${speech.isListening}');
  //   lastStatus = status;

  // int closestVal = lastWords.toLowerCase().compareTo(
  //     letter.toLowerCase()); //compare correct answer to voice input

  // int closestIndex =
  //     -1; //index of closest value, if -1 then result.recongizedwords
  // if (status == 'done') {
  //   //check if alternates are closer to correct answer
  //   for (int i = 0; i < alternates.length; i++) {
  //     String tempString = alternates[i].recognizedWords;
  //     int temp = tempString.toLowerCase().compareTo(letter.toLowerCase());
  //     if (temp.abs() < closestVal.abs()) {
  //       print("temp < closestVal");
  //       print("tempString: $tempString");
  //       print("lastWords: $lastWords");
  //       print("tempInt: $temp");
  //       print("closestValInt: $closestVal");

  //       closestIndex = i;
  //       closestVal = temp;
  //     }
  //   }
  //   if (closestIndex == -1) {
  //     checkAnswer(lastWords);
  //   } else {
  //     print("there was another");
  //     print(alternates[closestIndex].recognizedWords);

  //     setState(() {
  //       lastWords = alternates[closestIndex].recognizedWords;
  //     });

  //     checkAnswer(alternates[closestIndex].recognizedWords);
  //   }
  // }
  String displayText() {
    var question = quizBrain.getQuestionText();
    return question;
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
}

// void displayText() {
//     if (!started) {
//       setState(() {
//         question = quizBrain.getQuestionText();
//       });
//       started = true;
//     } else {
//       soundPress++;
//       if (soundPress > 2) {
//         setState(() {
//           enabled = false;
//         });
//       } else {
//         print("play local asset");
//       }
//     }
//   }

//   void getNewQuestion() {
//     setState(() {
//       question = quizBrain.getQuestionText();
//     });
//     upperLetterImage = emptyImage;
//     lowerLetterImage = emptyImage;
//   }

//   void checkAnswer(String userVoiceAnswer) {
//     enabled = true;
//     if (quizBrain.isFinished() == true) {
//       scoreKeeper = [];
//       quizBrain.reset();
//     } else {
//       List<String> ans = userVoiceAnswer.split(' ');
//       List<String> q = question.split(' ');

//       if (userVoiceAnswer.toLowerCase() == question.toLowerCase()) {
//         calc.correct++;
//         scoreKeeper.add(Icon(
//           Icons.star,
//           color: Colors.purpleAccent,
//           size: 31,
//         ));
//       } else {
//         if (scoreKeeper.isNotEmpty) {
//           quizBrain.stars--;
//           scoreKeeper.removeLast();
//         }
//       }

//       if (quizBrain.stars < 10) {
//         getNewQuestion();
//         qEnabled = true;
//       } else {
//         Timer(Duration(seconds: 1), () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ThreeShortFinish(
//                 stig: (calc.calculatePoints(calc.correct, calc.trys)) * 100,
//               ),
//             ),
//           );
//         });
//       }
//       calc.trys++;
//     }
//   }

void _logEvent(String eventDescription) {
  var eventTime = DateTime.now().toIso8601String();
  print('$eventTime $eventDescription');
  // }
}

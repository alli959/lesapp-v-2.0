// import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class VoiceService {
//   bool _hasSpeech = false;
//   bool _logEvents = false;
//   double level = 0.0;
//   double minSoundLevel = 50000;
//   double maxSoundLevel = -50000;
//   String lastWords = ' ';
//   List<SpeechRecognitionWords> alternates;
//   String lastError = '';
//   String lastStatus = '';
//   String _currentLocaleId = 'is_IS';
//   List<LocaleName> _localeNames = [];
//   QuizBrainLvlThree quizBrain = QuizBrainLvlThree();
//   final SpeechToText speech = SpeechToText();

//   // @override
//   // Future intitState() {
//   //   initSpeechState();
//   //   _switchLang('is_IS');
//   //   displayText();
//   //   super.initState();
//   // }

//   // String play() {
//   //   if (quizBrain.stars < 10) {
//   //     return 'STIG : ';
//   //   } else {
//   //     return 'STIG : ';
//   //   }
//   // }

//   // void displayText() {
//   //   if (!started) {
//   //     setState(() {
//   //       letter = quizBrain.getQuestionText();
//   //     });
//   //     started = true;
//   //   } else {
//   //     soundPress++;
//   //     if (soundPress > 2) {
//   //       setState(() {
//   //         enabled = false;
//   //       });
//   //     } else {
//   //       print("play local asset");
//   //     }
//   //   }
//   // }

//   void logEvent(String eventDescription) {
//     if (_logEvents) {
//       var eventTime = DateTime.now().toIso8601String();
//       print('$eventTime $eventDescription');
//     }
//   }
//   void errorListener(SpeechRecognitionError error) {
//     _logEvent(
//         'Received error status: $error, listening: ${speech.isListening}');
//     setState(() {
//       lastError = '${error.errorMsg} - ${error.permanent}';
//     });
//   }

//   void statusListener(String status) {
//     _logEvent(
//         'Received listener status: $status, listening: ${speech.isListening}');
//     setState(() {
//       lastStatus = '$status';
//     });
//     int closestVal = lastWords.toLowerCase().compareTo(
//         letter.toLowerCase()); //compare correct answer to voice input

//     int closestIndex =
//         -1; //index of closest value, if -1 then result.recongizedwords
//     if (status == 'done') {
//       //check if alternates are closer to correct answer
//       for (int i = 0; i < alternates.length; i++) {
//         String tempString = alternates[i].recognizedWords;
//         int temp = tempString.toLowerCase().compareTo(letter.toLowerCase());
//         if (temp.abs() < closestVal.abs()) {
//           print("temp < closestVal");
//           print("tempString: $tempString");
//           print("lastWords: $lastWords");
//           print("tempInt: $temp");
//           print("closestValInt: $closestVal");

//           closestIndex = i;
//           closestVal = temp;
//         }
//       }
//       if (closestIndex == -1) {
//         checkAnswer(lastWords);
//       } else {
//         print("there was another");
//         print(alternates[closestIndex].recognizedWords);

//         setState(() {
//           lastWords = alternates[closestIndex].recognizedWords;
//         });

//         checkAnswer(alternates[closestIndex].recognizedWords);
//       }
//     }
//   }
// }

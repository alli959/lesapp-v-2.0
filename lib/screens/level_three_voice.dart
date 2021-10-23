import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplateVoice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/trash-geyma/letters.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'dart:math';

class LevelThreeVoice extends StatelessWidget {
  static const String id = 'level_three_short_voice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: guli, title: Text('Raddgreining')),
      endDrawer: SideMenu(),
      body: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Letters letters = Letters();
  QuizBrainLvlThree quizBrain = QuizBrainLvlThree();
  TotalPoints calc = TotalPoints();
  List<Icon> scoreKeeper = []; // Empty list
  DatabaseService databaseService = DatabaseService();
  Color circleColorOne = cardColorLvlThree;
  Color circleColorTwo = cardColorLvlThree;
  int soundPress = 0;
  bool enabled = true;
  bool qEnabled = true;
  String letter = ' ';
  String answer = ' ';
  bool started = false;
  double soundCircleSize = 100;
  double soundPad = 100;
  double soundPadBottom = 0;
  double soundIconSize = 50;
  String upperLetterImageCorrect = 'assets/images/star.png';
  String lowerLetterImageCorrect = 'assets/images/star.png';
  String upperLetterImage = 'assets/images/empty.png';
  String lowerLetterImage = 'assets/images/empty.png';
  String emptyImage = 'assets/images/empty.png';
  Color letterColor = Colors.black;

  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = ' ';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = 'is_IS';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    initSpeechState();
    _switchLang('is_IS');
    super.initState();
  }

  String play() {
    if (quizBrain.stars < 10) {
      return 'STIG : ';
    } else {
      return 'STIG : ';
    }
  }

  void displayText() {
    if (!started) {
      setState(() {
        letter = quizBrain.getQuestionText();
      });
      started = true;
    } else {
      soundPress++;
      if (soundPress > 2) {
        setState(() {
          enabled = false;
        });
      } else {
        print("play local asset");
      }
    }
  }

  void checkAnswer(String userVoiceAnswer) {
    enabled = true;

    if (quizBrain.isFinished() == true) {
      scoreKeeper = [];
      quizBrain.reset();
    } else {
      print("userVoiceAnswer");
      print("textAnswer");
    }
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      // Get the list of languages installed on the supporting platform so they
      // can be displayed in the UI for selection by the user.
      _localeNames = await speech.locales();
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 4,
            child: RecognitionResultsWidget(
                lastWords: lastWords,
                level: level,
                startListening: startListening,
                letter: letter,
                answer: lastWords,
                scoreKeeper: scoreKeeper,
                trys: calc.trys,
                correct: calc.correct.toString(),
                stig: play() + calc.checkPoints(calc.correct, calc.trys),
                cardColor: cardColor,
                stigColor: lightBlue,
                fontSize: 39,
                bottomBar: BottomBar(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    image: 'assets/images/bottomBar_bl.png'),
                shadowLevel: 30),
          ),
          Expanded(
            flex: 1,
            child: ErrorWidget(lastError: lastError),
          ),
          SpeechStatusWidget(speech: speech),
        ]),
      ),
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key key,
    @required this.lastWords,
    @required this.level,
    @required this.startListening,
    @required this.letter,
    @required this.answer,
    @required this.scoreKeeper,
    @required this.trys,
    @required this.correct,
    @required this.stig,
    @required this.cardColor,
    @required this.stigColor,
    @required this.fontSize,
    @required this.bottomBar,
    @required this.shadowLevel,
  }) : super(key: key);

  final String lastWords;
  final double level;
  final Function startListening;
  final String letter;
  final String answer;
  final List<Icon> scoreKeeper;
  final int trys;
  final String correct;
  final String stig;
  final Color cardColor;
  final Color stigColor;
  final int fontSize;
  final bottomBar;
  final int shadowLevel;

  @override
  Widget build(BuildContext context) {
    return LevelTemplateVoice(
        fontSize: 39,
        cardColor: cardColorLvlThree,
        stigColor: lightBlue,
        shadowLevel: 30,
        letter: letter,
        scoreKeeper: scoreKeeper,
        trys: trys,
        correct: correct,
        stig: stig,
        bottomBar: bottomBar,
        answer: answer);
  }

  // Widget build(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       Center(
  //         child: Text(
  //           'Recognized Words',
  //           style: TextStyle(fontSize: 22.0),
  //         ),
  //       ),
  //       Expanded(
  //         child: Stack(
  //           children: <Widget>[
  //             Container(
  //               color: Theme.of(context).selectedRowColor,
  //               child: Center(
  //                 child: Text(
  //                   lastWords,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //             Positioned.fill(
  //               bottom: 10,
  //               child: Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Container(
  //                   width: 40,
  //                   height: 40,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                           blurRadius: .26,
  //                           spreadRadius: level * 1.5,
  //                           color: Colors.black.withOpacity(.05))
  //                     ],
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.all(Radius.circular(50)),
  //                   ),
  //                   child: IconButton(
  //                     icon: Icon(Icons.mic),
  //                     onPressed: () => startListening(),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key key,
    @required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

// class SessionOptionsWidget extends StatelessWidget {
//   const SessionOptionsWidget(this.currentLocaleId, this.switchLang,
//       this.localeNames, this.logEvents, this.switchLogging,
//       {Key key})
//       : super(key: key);

//   final String currentLocaleId;
//   final void Function(String) switchLang;
//   final void Function(bool) switchLogging;
//   final List<LocaleName> localeNames;
//   final bool logEvents;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         // Row(
//         //   children: [
//         //     Text('Language: '),
//         //     DropdownButton<String>(
//         //       onChanged: (selectedVal) => switchLang(selectedVal),
//         //       value: currentLocaleId,
//         //       items: localeNames
//         //           .map(
//         //             (localeName) => DropdownMenuItem(
//         //               value: localeName.localeId,
//         //               child: Text(localeName.name),
//         //             ),
//         //           )
//         //           .toList(),
//         //     ),
//         //   ],
//         // ),
//         Row(
//           children: [
//             Text('Log events: '),
//             Checkbox(
//               value: logEvents,
//               onChanged: switchLogging,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key key,
    @required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: speech.isListening
            ? Text(
                "I'm listening...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'Not listening',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

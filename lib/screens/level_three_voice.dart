import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplateVoice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/screens/level_three_short_finish.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:Lesaforrit/trash-geyma/letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'dart:math';

class LevelThreeVoice extends StatelessWidget {
  static const String id = 'level_three_short_voice';
  @override
  Widget build(BuildContext context) {
    final _speech = RepositoryProvider.of<VoiceService>(context);

    return BlocProvider<VoiceBloc>(
      create: (context) => VoiceBloc(_speech),
      child: Scaffold(
        appBar: AppBar(backgroundColor: guli, title: Text('Raddgreining')),
        endDrawer: SideMenu(),
        body: QuizPage(),
      ),
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
  Function listeningUpdate;

  @override
  void initState() {
    displayText();
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

  void getNewQuestion() {
    setState(() {
      letter = quizBrain.getQuestionText();
    });
    upperLetterImage = emptyImage;
    lowerLetterImage = emptyImage;
  }

  void checkAnswer(String userVoiceAnswer) {
    enabled = true;
    if (quizBrain.isFinished() == true) {
      scoreKeeper = [];
      quizBrain.reset();
    } else {
      List<String> ans = userVoiceAnswer.split(' ');
      List<String> q = letter.split(' ');

      if (userVoiceAnswer.toLowerCase() == letter.toLowerCase()) {
        calc.correct++;
        scoreKeeper.add(Icon(
          Icons.star,
          color: Colors.purpleAccent,
          size: 31,
        ));
      } else {
        if (scoreKeeper.isNotEmpty) {
          quizBrain.stars--;
          scoreKeeper.removeLast();
        }
      }

      if (quizBrain.stars < 10) {
        getNewQuestion();
        qEnabled = true;
      } else {
        Timer(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThreeShortFinish(
                stig: (calc.calculatePoints(calc.correct, calc.trys)) * 100,
              ),
            ),
          );
        });
      }
      calc.trys++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _voiceBloc = BlocProvider.of<VoiceBloc>(context);
    listeningUpdate(String lastWords, bool isListening) async {
      _voiceBloc.add(isListeningEvent(isListening: isListening));
      _voiceBloc.add(LastWordsEvent(lastWords: lastWords));
    }

    _voiceBloc.add(VoiceInitializeEvent(callback: listeningUpdate));
    return MaterialApp(
        home: Scaffold(
            body:
                BlocListener<VoiceBloc, VoiceState>(listener: (context, state) {
      if (state is VoiceFailure) {
        print("voice failure, why is this happening?");
      }
    }, child: BlocBuilder<VoiceBloc, VoiceState>(builder: (context, state) {
      if (state is VoiceLoading) {
        return Loading();
      }
      if (state is VoiceFailure) {}

      return Column(
        children: [
          Expanded(
            flex: 4,
            child: RecognitionResultsWidget(
                listeningUpdate: listeningUpdate,
                letter: letter,
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).backgroundColor,
            child: Center(child: BlocBuilder<VoiceBloc, VoiceState>(
              builder: (context, state) {
                if (state is IsListeningState) {
                  if (state.isListening) {
                    return Text(
                      "I'm listening...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  }
                }
                return Text("Not listening",
                    style: TextStyle(fontWeight: FontWeight.bold));
              },
            )),
          ),
        ],
      );
    }))));
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key key,
    @required this.listeningUpdate,
    @required this.letter,
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
  final Function listeningUpdate;
  final String letter;
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
      listeningUpdate: listeningUpdate,
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
    );
  }
}

// /// Display the current status of the listener
// class SpeechStatusWidget extends StatelessWidget {
//   const SpeechStatusWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       color: Theme.of(context).backgroundColor,
//       child: Center(child: BlocBuilder<VoiceBloc, VoiceState>(
//         builder: (context, state) {
//           if (state is VoiceStart) {
//             return Text(
//               "I'm listening...",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             );
//           } else {
//             return Text(
//               "Not listening",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             );
//           }
//         },
//       )),
//     );
//   }
// }

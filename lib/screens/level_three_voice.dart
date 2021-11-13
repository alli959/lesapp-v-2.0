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
  String question = ' ';
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
        question = quizBrain.getQuestionText();
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
      question = quizBrain.getQuestionText();
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
      List<String> q = question.split(' ');

      if (userVoiceAnswer.toLowerCase() == question.toLowerCase()) {
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
    listeningUpdate(String lastWords, List<SpeechRecognitionWords> alternates,
        bool isListening, String question) {
      if (!isListening) {}
      _voiceBloc.add(UpdateEvent(
          lastWords: lastWords,
          alternates: alternates,
          isListening: isListening,
          question: question));
    }

    _voiceBloc.add(VoiceInitializeEvent(callback: listeningUpdate));
    return MaterialApp(
      home: Scaffold(
        body: BlocListener<VoiceBloc, VoiceState>(
          listener: (context, state) {
            if (state is VoiceFailure) {
              print("voice failure, why is this happening?");
            }
          },
          child: BlocBuilder<VoiceBloc, VoiceState>(builder: (context, state) {
            if (state is VoiceLoading) {
              return Loading();
            }
            if (state is VoiceFailure) {}

            if (state is UpdateState) {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: RecognitionResultsWidget(
                        listeningUpdate: listeningUpdate,
                        question: question,
                        lastWords: state.lastWords,
                        scoreKeeper: scoreKeeper,
                        trys: calc.trys,
                        correct: calc.correct.toString(),
                        stig:
                            play() + calc.checkPoints(calc.correct, calc.trys),
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
                    child: SpeechStatusWidget(isListening: state.isListening),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: RecognitionResultsWidget(
                      listeningUpdate: listeningUpdate,
                      question: question,
                      lastWords: ' ',
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
                  child: SpeechStatusWidget(isListening: false),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key key,
    @required this.listeningUpdate,
    @required this.question,
    @required this.lastWords,
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
  final String question;
  final String lastWords;
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
    print("${fontSize}");
    print('${cardColor}');
    print('${stigColor}');
    print('${shadowLevel}');
    print('${question}');
    print('${lastWords}');
    print('${scoreKeeper}');
    print('${trys}');
    print('${correct}');
    print('${stig}');
    print('${bottomBar}');
    return LevelTemplateVoice(
      listeningUpdate: listeningUpdate,
      fontSize: 39,
      cardColor: cardColorLvlThree,
      stigColor: lightBlue,
      shadowLevel: 30,
      question: question,
      lastWords: lastWords,
      scoreKeeper: scoreKeeper,
      trys: trys,
      correct: correct,
      stig: stig,
      bottomBar: bottomBar,
    );
  }
}

// /// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key key,
    @required this.isListening,
  }) : super(key: key);
  final bool isListening;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: isListening
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

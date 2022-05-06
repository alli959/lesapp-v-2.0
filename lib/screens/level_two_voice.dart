import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/my_flutter_app_icons.dart';
import 'package:Lesaforrit/components/scorekeeper.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplateVoice.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/screens/level_three_short_finish.dart';
import 'package:Lesaforrit/screens/level_two_voice_finish.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:Lesaforrit/trash-geyma/letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'dart:math';

import '../services/save_audio.dart';

class LevelTwoVoice extends StatelessWidget {
  static const String id = 'level_Two_voice';
  @override
  Widget build(BuildContext context) {
    final _speech = RepositoryProvider.of<VoiceService>(context);
    final _audioSave = RepositoryProvider.of<SaveAudio>(context);

    return BlocProvider<VoiceBloc>(
      create: (context) => VoiceBloc(_speech, 'level_2', _audioSave),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBar,
          title: Text('Raddgreining Orða',
              style: TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 57, 53, 53))),
          iconTheme: IconThemeData(size: 36, color: Colors.black),
        ),
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
  QuizBrainLvlThreeVoice quizBrain = QuizBrainLvlThreeVoice();
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

  void getNewQuestion() {
    setState(() {
      question = quizBrain.getQuestionText();
    });
    upperLetterImage = emptyImage;
    lowerLetterImage = emptyImage;
  }

  // void checkAnswer(String userVoiceAnswer) {
  //   enabled = true;
  //   if (quizBrain.isFinished() == true) {
  //     scoreKeeper = [];
  //     quizBrain.reset();
  //   } else {
  //     List<String> ans = userVoiceAnswer.split(' ');
  //     List<String> q = question.split(' ');

  //     if (userVoiceAnswer.toLowerCase() == question.toLowerCase()) {
  //       calc.correct++;
  //       scoreKeeper.add(Icon(
  //         Icons.star,
  //         color: Colors.purpleAccent,
  //         size: 31,
  //       ));
  //     } else {
  //       if (scoreKeeper.isNotEmpty) {
  //         quizBrain.stars--;
  //         scoreKeeper.removeLast();
  //       }
  //     }

  //     if (quizBrain.stars < 10) {
  //       getNewQuestion();
  //       qEnabled = true;
  //     } else {
  //       Timer(Duration(seconds: 1), () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ThreeShortFinish(
  //               stig: (calc.calculatePoints(calc.correct, calc.trys)) * 100,
  //             ),
  //           ),
  //         );
  //       });
  //     }
  //     calc.trys++;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _voiceBloc = BlocProvider.of<VoiceBloc>(context);
    listeningUpdate(
        String lastWords,
        List<SpeechRecognitionAlternative> alternates,
        bool isListening,
        String question) {
      // if (!isListening) {
      //   _voiceBloc.add(NewQuestionEvent(question: question));
      // }
      _voiceBloc.add(UpdateEvent(
          lastWords: lastWords,
          alternates: alternates,
          isListening: isListening,
          question: question));
    }

    checkAnswer(
      bool onePoint,
      bool twoPoints,
      bool threePoints,
      bool fourPoints,
      bool fivePoints,
      TotalPoints calc,
    ) {
      _voiceBloc.add(ScoreKeeperEvent(
          onePoint: onePoint,
          twoPoints: twoPoints,
          threePoints: threePoints,
          fourPoints: fourPoints,
          fivePoints: fivePoints));
    }

    // _voiceBloc.add(VoiceInitializeEvent(listeningUpdate: listeningUpdate));
    return Container(
      child: Scaffold(
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

            if (state is ScoreKeeper) {
              quizBrain.stars++;
              if (state.fivePoints) {
                scoreKeeper.add(Icon(
                  Icons.star,
                  color: Colors.purpleAccent,
                  size: 31,
                ));
              } else if (state.fourPoints) {
                scoreKeeper.add(Icon(
                  MyFlutterApp.fourpoints,
                  color: Colors.purpleAccent,
                  size: 31,
                ));
              } else if (state.threePoints) {
                scoreKeeper.add(Icon(
                  MyFlutterApp.threepoints,
                  color: Colors.purpleAccent,
                  size: 31,
                ));
              } else if (state.twoPoints) {
                scoreKeeper.add(Icon(
                  MyFlutterApp.twopoints,
                  color: Colors.purpleAccent,
                  size: 31,
                ));
              } else if (state.onePoint) {
                scoreKeeper.add(Icon(
                  MyFlutterApp.onepoint,
                  color: Colors.purpleAccent,
                  size: 31,
                ));
              } else {
                print("SCOREKEEPER REMOVE");
                if (scoreKeeper.isNotEmpty) {
                  scoreKeeper.removeLast();
                }
              }
              if (quizBrain.isFinished()) {
                _voiceBloc.add(ResetEvent());
                Timer(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TwoVoiceFinish(
                        stig: (calc.calculatePoints(calc.correct, calc.trys)) *
                            100,
                      ),
                    ),
                  );
                });
              }
            }
            if (state is UpdateState) {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: RecognitionResultsWidget(
                        listeningUpdate: listeningUpdate,
                        checkAnswer: checkAnswer,
                        question: state.question,
                        lastWords: state.lastWords,
                        scoreKeeper: scoreKeeper,
                        trys: calc.trys,
                        correct: calc.correct.toString(),
                        stig:
                            play() + calc.checkPoints(calc.correct, calc.trys),
                        cardColor: cardColorLvlTwo,
                        stigColor: lightGreen,
                        fontSize: 39,
                        bottomBar: BottomBar(
                            onTap: () {
                              _voiceBloc.add(ResetEvent());
                              Navigator.pop(context);
                            },
                            image: 'assets/images/bottomBar_bl.png'),
                        shadowLevel: 30),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Color.fromARGB(255, 109, 223, 112),
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
                      checkAnswer: checkAnswer,
                      question: question,
                      lastWords: ' ',
                      scoreKeeper: scoreKeeper,
                      trys: calc.trys,
                      correct: calc.correct.toString(),
                      stig: play() + calc.checkPoints(calc.correct, calc.trys),
                      cardColor: cardColorLvlTwo,
                      stigColor: lightGreen,
                      fontSize: 39,
                      bottomBar: BottomBar(
                          onTap: () {
                            _voiceBloc.add(ResetEvent());
                            Navigator.pop(context);
                          },
                          image: 'assets/images/bottomBar_bl.png'),
                      shadowLevel: 30),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Color.fromARGB(255, 109, 223, 112),
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
    @required this.checkAnswer,
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
  final Function checkAnswer;
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
      checkAnswer: checkAnswer,
      fontSize: 39,
      cardColor: cardColorLvlTwo,
      stigColor: lightGreen,
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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: isListening
            ? Text(
                "Að hlusta...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'Ekki að hlusta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

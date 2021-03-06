import 'dart:async';
import 'package:Lesaforrit/bloc/serverless/serverless_bloc.dart';
import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:Lesaforrit/components/scorekeeper.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplate.dart';

import 'package:Lesaforrit/models/serverless/quiz_brain_lvlThree_Easy.dart';

import 'package:Lesaforrit/services/get_data.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:Lesaforrit/trash-geyma/letters.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'level_three_short_finish.dart';

// B O R D  E I T T
class LevelThreeShort extends StatelessWidget {
  static const String id = 'level_three_short';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServerlessBloc>(
        create: (context) {
          final _data = RepositoryProvider.of<GetData>(context);
          final _database = RepositoryProvider.of<DatabaseService>(context);
          var prefVoice = _database.getPreferedVoice();
          return ServerlessBloc(_data, 'sentences', 'easy')
            ..add(FetchEvent(prefvoice: prefVoice));
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBar,
            title: Text('Stuttar setningar',
                style: TextStyle(fontSize: 22, color: Colors.black)),
            iconTheme: IconThemeData(size: 36, color: Colors.black),
          ),
          endDrawer: SideMenu(),
          body: QuizPage(),
        ));
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

// The state of the widget
class _QuizPageState extends State<QuizPage> {
  QuizBrainLvlThreeEasy quizBrain = QuizBrainLvlThreeEasy();
  TotalPoints calc = TotalPoints();
  List<Icon> scoreKeeper = []; // Empty list
  DatabaseService databaseService = DatabaseService();
  int soundPress = 0;
  bool enabled = true;
  bool qEnabled = true;
  String letterOne = '';
  String letterTwo = '';
  bool started = false;
  double soundCircleSize = 100;
  double soundPad = 100;
  double soundPadBottom = 0;
  double soundIconSize = 50;

  String upperLetterImageCorrect = 'assets/images/star.png';
  String lowerLetterImageCorrect = 'assets/images/star.png';
  String upperLetterImageIncorrect = 'assets/images/sorryWrong.png';
  String lowerLetterImageIncorrect = 'assets/images/sorryWrong.png';
  String upperLetterImage = 'assets/images/empty.png';
  String lowerLetterImage = 'assets/images/empty.png';
  String emptyImage = 'assets/images/empty.png';
  String typeofgame = 'sentences';
  String typeofdifficulty = 'easy'; // change depending on player skill
  Color letterColorOne = Colors.black;
  Color letterColorTwo = Colors.black;

  String play() {
    if (quizBrain.stars < 10) {
      quizBrain.playLocalAsset();
      return 'STIG : ';
    } else {
      return 'STIG : ';
    }
  }

  void checkAnswer(bool wasCorrect) {
    enabled = true;
    soundPress = 0;

    if (quizBrain.isFinished() == true) {
      scoreKeeper = [];
      quizBrain.reset(); // empty scorekeeper
    } else {
      if (wasCorrect) {
        // Notandi  valdi  R ?? T T  //  C O R R E C T

        calc.correct++;
        calc.trys++;
        scoreKeeper.add(Icon(
          Icons.star,
          color: Colors.purpleAccent,
          size: 31,
        ));
        quizBrain.stars++;
        // delay();
      } else {
        // Notandi valdi  R A N G T  //  F A L S E
        if (scoreKeeper.isNotEmpty) {
          quizBrain.stars--;
          scoreKeeper.removeLast();
          calc.trys++;
        } else {
          calc.trys++;
        }
      }
    }
    // Kemur me?? n??ja spurningu, en ef notandi hefur fengi?? 10 stj??rnur ???? flytaj ?? finishbor?? (e. 1 sec)
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
  }

  // Athugar svar notanda og setur stj??rnu e??a kross eftir hvort s?? r??tt
  void check(answer) {
    if (answer == 'upperCorrect') {
      upperLetterImage = upperLetterImageCorrect;
      quizBrain.playCorrect();
    }
    if (answer == 'lowerCorrect') {
      quizBrain.playCorrect();
      lowerLetterImage = lowerLetterImageCorrect;
    }
    if (answer == 'upperIncorrect') {
      quizBrain.playIncorrect();
      upperLetterImage = upperLetterImageIncorrect;
    }
    if (answer == 'lowerIncorrect') {
      quizBrain.playIncorrect();
      upperLetterImage = upperLetterImageIncorrect;
    }
  }

  void getNewQuestion() {
    letterOne = quizBrain.getQuestionText1();
    letterTwo = quizBrain.getQuestionText2();
    upperLetterImage = emptyImage;
    lowerLetterImage = emptyImage;
    play();
  }

  @override
  Widget build(BuildContext context) {
    final _serverlessBloc = BlocProvider.of<ServerlessBloc>(context);
    // _serverlessBloc
    //     .add(FetchEvent(typeofgame: "sentences", typeofgamedifficulty: "easy"));

    // getter() {
    //   _serverlessBloc.add(FetchEvent());
    // }

    return BlocBuilder<ServerlessBloc, ServerlessState>(
        builder: (context, state) {
      if (state is ServerlessLoading) {
        print("loading going on");
        return Loading();
      }
      if (state is ServerlessFetch) {
        print("state is serverlessfetch");
        if (!started) {
          quizBrain.addData(state.questionBank);
        }
      }
      if (state is CheckAnswerState) {
        print("State of checkAnswerState iss $state");
        if (state.upperImageCorrect) {
          check('upperCorrect');
        }
        if (state.lowerImageCorrect) {
          check('lowerCorrect');
        }
        if (state.upperImageIncorrect) {
          check('upperIncorrect');
        }
        if (state.lowerImageIncorrect) {
          check('lowerIncorrect');
        }
      }
      if (state is NewQuestionState) {
        checkAnswer(state.wasCorrect);
      }

      if (state is PlayGameState) {
        letterOne = quizBrain.getQuestionText1();
        letterTwo = quizBrain.getQuestionText2();
        enabled = true;
        soundCircleSize = 55;
        soundPad = 0.0;
        soundPadBottom = 10;
        soundIconSize = 35;
        started = true;
        quizBrain.playLocalAsset();
      }
      print("state is neither serverlessfetch nor loading");
      return (LevelTemplate(
          // fontSize: 39,
          //     shadowLevel: 30,
          //     cardColor: cardColorLvlThree,
          //     stigColor: lightBlue,
          //     soundCircleSize: soundCircleSize,
          //     soundPad: soundPad,
          //     soundPadBottom: soundPadBottom,
          //     soundIconSize: soundIconSize,
          //     enabled: enabled,
          //     onPressed: !enabled ? null : () => soundDora(),
          //     onPressed2: !enabled ? null : () => soundKarl(),
          //     upperLetterImage: upperLetterImage,
          //     lowerLetterImage: lowerLetterImage,
          //     letterOne: letterOne,
          //     letterTwo: letterTwo,
          //     onPress: !qEnabled
          //         ? null
          //         : () {
          //             check(true);
          //             Future.delayed(const Duration(milliseconds: 1400), () {
          //               setState(() {
          //                 checkAnswer(true);
          //               });
          //             });
          //           },
          //     onPress2: !qEnabled
          //         ? null
          //         : () {
          //             check(false);
          //             Future.delayed(const Duration(milliseconds: 1400), () {
          //               setState(() {
          //                 checkAnswer(false);
          //               });
          //             });
          //           },
          //     scoreKeeper: scoreKeeper,
          //     trys: calc.trys.toString(),
          //     correct: calc.correct.toString(),
          //     bottomBar: BottomBar(
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //         image: 'assets/images/bottomBar_bl.png'),
          //     stig: play() + calc.checkPoints(calc.correct, calc.trys)));
          fontSize: 39,
          cardColor: cardColorLvlThree,
          stigColor: lightBlue,
          shadowLevel: 30,
          soundCircleSize: soundCircleSize,
          soundPad: soundPad,
          soundPadBottom: soundPadBottom,
          soundIconSize: soundIconSize,
          enabled: enabled,
          onPlay: !enabled ? null : () => _serverlessBloc.add(PlayGameEvent()),
          onPressed: !enabled ? null : () => quizBrain.playDora(),
          onPressed2: !enabled ? null : () => quizBrain.playKarl(),
          upperLetterImage: upperLetterImage,
          lowerLetterImage: lowerLetterImage,
          letterOne: letterOne,
          letterTwo: letterTwo,
          onPress: !qEnabled
              ? null
              : () {
                  _serverlessBloc.add(CheckAnswerEvent(
                      userAnswer: true,
                      correctAnswer: quizBrain.getCorrectAnswer()));
                },
          onPress2: !qEnabled
              ? null
              : () {
                  _serverlessBloc.add(CheckAnswerEvent(
                      userAnswer: false,
                      correctAnswer: quizBrain.getCorrectAnswer()));
                },
          scoreKeeper: scoreKeeper,
          trys: calc.trys.toString(),
          correct: calc.correct.toString(),
          bottomBar: BottomBar(
              onTap: () {
                Navigator.pop(context);
              },
              image: 'assets/images/bottomBar_bl.png'),
          stig: "STIG : ${calc.checkPoints(calc.correct, calc.trys)}"));
    });
  }
}

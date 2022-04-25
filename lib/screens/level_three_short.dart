import 'dart:async';
import 'package:Lesaforrit/bloc/serverless/serverless_bloc.dart';
import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:Lesaforrit/components/scorekeeper.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplate.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_short.dart';
import 'package:Lesaforrit/models/serverless/quiz_brain_lvlThree_Easy.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo_short.dart';
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
          return ServerlessBloc(_data, 'sentences', 'easy')..add(FetchEvent());
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
  Letters letters = Letters();
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

  void sound() async {
    if (!started) {
      setState(() {
        letterOne = quizBrain.getQuestionText1();
        letterTwo = quizBrain.getQuestionText2();
        enabled = true;
        soundCircleSize = 55;
        soundPad = 0.0;
        soundPadBottom = 10;
        soundIconSize = 35;
      });
      started = true;
    } else {
      soundPress++;
      if (soundPress > 2) {
        setState(() {
          enabled = false;
        });
      } else {
        quizBrain.playLocalAsset();
      }
    }
  }

  void checkAnswer(bool userPickedAnswer) {
    enabled = true;
    soundPress = 0;

    if (quizBrain.isFinished() == true) {
      scoreKeeper = [];
      quizBrain.reset(); // empty scorekeeper
    } else {
      if (userPickedAnswer == quizBrain.getCorrectAnswer()) {
        // Notandi  valdi  R É T T  //  C O R R E C T

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
    // Kemur með nýja spurningu, en ef notandi hefur fengið 10 stjörnur þá flytaj í finishborð (e. 1 sec)
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

  // Athugar svar notanda og setur stjörnu eða kross eftir hvort sé rétt
  void check(bool userAnswered) {
    qEnabled = false;
    if (userAnswered == true) {
      // NOTANDI VALDI EFRI STAF
      if (userAnswered == quizBrain.getCorrectAnswer()) {
        setState(() {
          // og það var rétt svar
          upperLetterImage = upperLetterImageCorrect;
        });
      } else {
        // Neðri stafur var hins vegar rétt svar
        setState(() {
          upperLetterImage = 'assets/images/sorryWrong.png';
          // lowerLetterImage = 'assets/images/sorryCorrect.png';
        });
      }
    } else {
      // NOTANDI VALDI NEÐRI STAF
      if (userAnswered == quizBrain.getCorrectAnswer()) {
        setState(() {
          // og það var rétt svar
          lowerLetterImage = lowerLetterImageCorrect;
        });
      } else {
        // Efri stafur er hins vegar rétt svar
        setState(() {
          lowerLetterImage = 'assets/images/sorryWrong.png';
          // upperLetterImage = 'assets/images/sorryCorrect.png';
        });
      }
    }
  }

  void getNewQuestion() {
    letterOne = quizBrain.getQuestionText1();
    letterTwo = quizBrain.getQuestionText2();
    upperLetterImage = emptyImage;
    lowerLetterImage = emptyImage;
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
        quizBrain.addData(state.questionBank);
        return (LevelTemplate(
            fontSize: 39,
            shadowLevel: 30,
            cardColor: cardColorLvlThree,
            stigColor: lightBlue,
            soundCircleSize: soundCircleSize,
            soundPad: soundPad,
            soundPadBottom: soundPadBottom,
            soundIconSize: soundIconSize,
            enabled: enabled,
            onPressed: !enabled ? null : () => sound(),
            upperLetterImage: upperLetterImage,
            lowerLetterImage: lowerLetterImage,
            letterOne: letterOne,
            letterTwo: letterTwo,
            onPress: !qEnabled
                ? null
                : () {
                    check(true);
                    Future.delayed(const Duration(milliseconds: 1400), () {
                      setState(() {
                        checkAnswer(true);
                      });
                    });
                  },
            onPress2: !qEnabled
                ? null
                : () {
                    check(false);
                    Future.delayed(const Duration(milliseconds: 1400), () {
                      setState(() {
                        checkAnswer(false);
                      });
                    });
                  },
            scoreKeeper: scoreKeeper,
            trys: calc.trys.toString(),
            correct: calc.correct.toString(),
            bottomBar: BottomBar(
                onTap: () {
                  Navigator.pop(context);
                },
                image: 'assets/images/bottomBar_bl.png'),
            stig: play() + calc.checkPoints(calc.correct, calc.trys)));
      }
      print("state is neither serverlessfetch nor loading");
      return (LevelTemplate(
          fontSize: 39,
          shadowLevel: 30,
          cardColor: cardColorLvlThree,
          stigColor: lightBlue,
          soundCircleSize: soundCircleSize,
          soundPad: soundPad,
          soundPadBottom: soundPadBottom,
          soundIconSize: soundIconSize,
          enabled: enabled,
          onPressed: !enabled ? null : () => sound(),
          upperLetterImage: upperLetterImage,
          lowerLetterImage: lowerLetterImage,
          letterOne: letterOne,
          letterTwo: letterTwo,
          onPress: !qEnabled
              ? null
              : () {
                  check(true);
                  Future.delayed(const Duration(milliseconds: 1400), () {
                    setState(() {
                      checkAnswer(true);
                    });
                  });
                },
          onPress2: !qEnabled
              ? null
              : () {
                  check(false);
                  Future.delayed(const Duration(milliseconds: 1400), () {
                    setState(() {
                      checkAnswer(false);
                    });
                  });
                },
          scoreKeeper: scoreKeeper,
          trys: calc.trys.toString(),
          correct: calc.correct.toString(),
          bottomBar: BottomBar(
              onTap: () {
                Navigator.pop(context);
              },
              image: 'assets/images/bottomBar_bl.png'),
          stig: play() + calc.checkPoints(calc.correct, calc.trys)));
    });
  }
}

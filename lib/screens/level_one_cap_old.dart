import 'dart:async';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplate.dart';

import 'package:Lesaforrit/models/serverless/quiz_brain_lvlOne.dart';
import 'package:Lesaforrit/trash-geyma/letters.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/serverless/serverless_bloc.dart';
import '../services/get_data.dart';
import '../shared/loading.dart';
import 'level_one_caps_finish.dart';

// B O R D  E I T T
class LevelOneCap extends StatelessWidget {
  static const String id = 'level_one_cap';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServerlessBloc>(
        create: (context) {
          final _data = RepositoryProvider.of<GetData>(context);
          final _database = RepositoryProvider.of<DatabaseService>(context);
          var prefVoice = _database.getPreferedVoice();
          return ServerlessBloc(_data, 'letters', 'cap')
            ..add(FetchEvent(prefvoice: prefVoice));
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBar,
            title: Text('Hástafir',
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
  QuizBrainLvlOne quizBrain = QuizBrainLvlOne(true);
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

  void soundDora() {
    print("At soundDora");
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
      // soundPress++;
      // if (soundPress > 2) {
      //   print("soundPress > 2 on Dóra....");
      //   setState(() {
      //     enabled = false;
      //   });
      // }
      //  else {
      quizBrain.playDora();
      // }
    }
  }

  void soundKarl() {
    print("At soundKarl");
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
      // soundPress++;
      // if (soundPress > 2) {
      //   print("soundpress > 2......");
      //   setState(() {
      //     enabled = false;
      //   });
      // } else {
      quizBrain.playKarl();
      // }
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
    if (quizBrain.stars < 10) {
      getNewQuestion();
      qEnabled = true;
    } else {
      Timer(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OneCapsFinish(
              stig: (calc.calculatePoints(calc.correct, calc.trys)) * 100,
            ),
          ),
        );
      });
    }
  }

  void check(bool userAnswered) {
    qEnabled = false;
    if (userAnswered == true) {
      if (userAnswered == quizBrain.getCorrectAnswer()) {
        setState(() {
          upperLetterImage = upperLetterImageCorrect;
        });
      } else {
        setState(() {
          upperLetterImage = 'assets/images/sorryWrong.png';
        });
      }
    } else {
      if (userAnswered == quizBrain.getCorrectAnswer()) {
        setState(() {
          lowerLetterImage = lowerLetterImageCorrect;
        });
      } else {
        setState(() {
          lowerLetterImage = 'assets/images/sorryWrong.png';
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
        return (LevelTemplate(
            fontSize: 100,
            cardColor: cardColor,
            stigColor: lightCyan,
            shadowLevel: 145,
            soundCircleSize: soundCircleSize,
            soundPad: soundPad,
            soundPadBottom: soundPadBottom,
            soundIconSize: soundIconSize,
            enabled: enabled,
            onPressed: !enabled ? null : () => soundDora(),
            onPressed2: !enabled ? null : () => soundKarl(),
            upperLetterImage: upperLetterImage,
            lowerLetterImage: lowerLetterImage,
            letterOne: letterOne,
            letterTwo: letterTwo,
            onPress: !qEnabled
                ? null
                : () {
                    check(true);
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      setState(() {
                        checkAnswer(true);
                      });
                    });
                  },
            onPress2: !qEnabled
                ? null
                : () {
                    check(false);
                    Future.delayed(const Duration(milliseconds: 1000), () {
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
                image: 'assets/images/bottomBar_ye.png'),
            stig: play() + calc.checkPoints(calc.correct, calc.trys)));
      }
      print("state is neither serverlessfetch nor loading");
      return (LevelTemplate(
          fontSize: 100,
          cardColor: cardColor,
          stigColor: lightCyan,
          shadowLevel: 145,
          soundCircleSize: soundCircleSize,
          soundPad: soundPad,
          soundPadBottom: soundPadBottom,
          soundIconSize: soundIconSize,
          enabled: enabled,
          onPressed: !enabled ? null : () => soundDora(),
          onPressed2: !enabled ? null : () => soundKarl(),
          upperLetterImage: upperLetterImage,
          lowerLetterImage: lowerLetterImage,
          letterOne: letterOne,
          letterTwo: letterTwo,
          onPress: !qEnabled
              ? null
              : () {
                  check(true);
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    checkAnswer(true);
                  });
                },
          onPress2: !qEnabled
              ? null
              : () {
                  check(false);
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    checkAnswer(false);
                  });
                },
          scoreKeeper: scoreKeeper,
          trys: calc.trys.toString(),
          correct: calc.correct.toString(),
          bottomBar: BottomBar(
              onTap: () {
                Navigator.pop(context);
              },
              image: 'assets/images/bottomBar_ye.png'),
          stig: play() + calc.checkPoints(calc.correct, calc.trys)));
    });
  }
}

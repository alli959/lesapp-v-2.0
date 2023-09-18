import 'dart:async';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplate.dart';
import 'package:Lesaforrit/screens/level_finish.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/serverless/serverless_bloc.dart';
import '../components/arguments.dart';
import '../models/listeners/level_listener.dart';
import '../services/audio_session.dart';
import '../services/get_data.dart';
import '../shared/loading.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';

class Level extends StatelessWidget {
  static const String id = 'level';

  LevelListener _levelListenerConfig;
  GameType _gameType;
  String _difficulty;

  Level(LevelArguments arguments) {
    this._gameType = arguments.gameType;
    this._levelListenerConfig = new LevelListener(arguments.gameType);
    this._difficulty = _levelListenerConfig.selecteddifficulty;
    this._levelListenerConfig.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServerlessBloc>(
        create: (context) {
          final _data = RepositoryProvider.of<GetData>(context);
          final _database = RepositoryProvider.of<DatabaseService>(context);
          var prefVoice = _database.getPreferedVoice();
          return ServerlessBloc(_data, _levelListenerConfig.typeofgame,
              _levelListenerConfig.selecteddifficulty)
            ..add(FetchEvent(prefvoice: prefVoice));
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBar,
            title: Text(_levelListenerConfig.title,
                style: TextStyle(fontSize: 22, color: Colors.black)),
            iconTheme: IconThemeData(size: 36, color: Colors.black),
          ),
          endDrawer: SideMenu(),
          body: QuizPage(config: _levelListenerConfig),
        ));
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.config}) : super(key: key);

  LevelListener config;

  @override
  _QuizPageState createState() => _QuizPageState();
}

// The state of the widget
class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain(typeofgame: "letters", isCap: true);
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
  String emptyImage = 'assets/images/empty.png';
  String upperLetterImage = 'assets/images/empty.png';
  String lowerLetterImage = 'assets/images/empty.png';
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
      enabled = true;
    } else {
      Timer(Duration(seconds: 1), () {
        // print("finish type is ${widget.config.finishtype.name}");
        Navigator.of(context).pushNamedAndRemoveUntil(
            LevelFinish.id, (Route<dynamic> route) => false,
            arguments: LevelFinishArguments(widget.config.finishtype,
                calc.calculatePoints(calc.correct, calc.trys) * 100));
      });
    }
  }

  void check(answer) {
    if (answer == 'upperCorrect') {
      quizBrain.playCorrect();
      upperLetterImage = upperLetterImageCorrect;
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
      lowerLetterImage = lowerLetterImageIncorrect;
    }
  }

  void getNewQuestion() {
    print("we are at the new question function");
    letterOne = quizBrain.getQuestionText1();
    letterTwo = quizBrain.getQuestionText2();
    upperLetterImage = emptyImage;
    lowerLetterImage = emptyImage;
    play();
  }

  @override
  Widget build(BuildContext context) {
    final _serverlessBloc = BlocProvider.of<ServerlessBloc>(context);
    final _audiosession = RepositoryProvider.of<AudioSessionService>(context);
    return BlocBuilder<ServerlessBloc, ServerlessState>(
        builder: (context, state) {
      if (state is ServerlessLoading) {
        print("loading going on");
        return Loading();
      }
      if (state is ServerlessFetch) {
        print("state is serverlessfetcherino");
        print("SERVERLESS FETCH AT LEVEL ${state.questionBank}");
        if (!started) {
          quizBrain.addData(
              state.questionBank,
              widget.config.isCap,
              widget.config.typeofgame,
              widget.config.selecteddifficulty,
              _audiosession);
        }
      }
      if (state is CheckAnswerState) {
        enabled = false;
        qEnabled = false;
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
        qEnabled = true;
        soundCircleSize = 55;
        soundPad = 0.0;
        soundPadBottom = 10;
        soundIconSize = 35;
        started = true;
        quizBrain.playLocalAsset();
      }
      print("state is neither serverlessfetch nor loading");
      return (LevelTemplate(
          fontSize: widget.config.fontsize,
          cardColor: widget.config.cardcolor,
          stigColor: widget.config.stigcolor,
          shadowLevel: widget.config.shadowlevel,
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
              image: widget.config.bottombarimage),
          stig: "STIG : ${calc.checkPoints(calc.correct, calc.trys)}"));
    });
  }
}

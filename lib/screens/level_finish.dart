import 'package:Lesaforrit/components/arguments.dart';
import 'package:Lesaforrit/models/finish_buildColumn.dart';
import 'package:Lesaforrit/models/quiz_brain_voice.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/wrapper.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/database/database_bloc.dart';
import '../bloc/user/authentication_bloc.dart';

import '../models/listeners/level_finish_listener.dart';
import '../models/quiz_brain.dart';
import '../models/set_score.dart';
import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';
import '../services/auth.dart';
import 'home/welcome.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'lvlThree_choose.dart';
import 'lvlTwo_choose.dart';

class LevelFinish extends StatelessWidget {
  double stig;
  FinishGameType gameType;
  FinishGameListener _config;

  LevelFinish(LevelFinishArguments args) {
    this.stig = args.score;
    this.gameType = args.gameType;
    this._config = new FinishGameListener(gameType);
    this._config.init();
  }

  // static const String id = 'LevelFinish';
  @override
  Widget build(BuildContext context) {
    print("stig is => $stig");
    // print("gameType is => ${this.gameType.name}");
    print("stig is => $stig");
    print("stig is => $stig");
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc..add(UpdateUserScore(score: stig, typeof: _config.typeofkey));
    return LevelFin(
      stig: stig,
      image: _config.image,
      undertext: '\n Stig!',
      appBarText: _config.appBarText,
    );
  }
}

class LevelFin extends StatelessWidget {
  LevelFin({
    @required this.stig,
    this.image,
    this.undertext,
    this.appBarText,
  });

  double stig;
  String image;
  String undertext;
  String appBarText;

  Widget button1(double stig, DatabaseBloc databaseBloc) {
    return SetScore(
      currentScore: stig.toStringAsFixed(0),
      level: LvlOneChoose.id,
      text: 'Borð 1: Stafir',
    );
  }

  Widget button2(double stig, DatabaseBloc databaseBloc) {
    return SetScore(
      currentScore: stig.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button3(double stig, DatabaseBloc databaseBloc) {
    return SetScore(
      currentScore: stig.toStringAsFixed(0),
      level: LvlThreeChoose.id,
      text: 'Borð 3: Setningar',
    );
  }

  Finish finish = Finish();
  QuizBrain quizBrain = QuizBrain();
  QuizBrainVoice quizBrainVoice = QuizBrainVoice();

  String writePoints() {
    quizBrain.reset();
    quizBrainVoice.reset();
    return stig.toStringAsFixed(0);
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);

    String highestScore = '\n Jei þú slóst metið þitt!';
    double stigamet = stig;
    return BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
      if (state is IsNewRecord) {
        if (state.newRecord) {
          highestScore = '\n Þú slóst metið þitt!';
          stigamet = state.record;
        } else {
          highestScore = '\n Metið þitt er ${state.record}';
        }
      }

      return finish.FinishMethod(
        highestScore,
        stigamet,
        context,
        formKey,
        appBarText,
        image,
        stig,
        button1(stig, databaseBloc),
        button2(stig, databaseBloc),
        button3(stig, databaseBloc),
        cardColor,
      );
    });
  }
}

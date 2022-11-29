import 'package:Lesaforrit/models/finish_buildColumn.dart';

import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/database/database_bloc.dart';
import '../bloc/user/authentication_bloc.dart';
import '../models/quiz_brain.dart';
import '../models/set_score.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';

import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';
import '../services/auth.dart';
import 'home/welcome.dart';
import 'lvlOne_choose.dart';

class OneCapsFinish extends StatelessWidget {
  OneCapsFinish({@required this.stig});
  double stig;
  static const String id = 'OneCapsFinish';

  @override
  Widget build(BuildContext context) {
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc..add(UpdateUserScore(score: stig, typeof: 'lvlOneCapsScore'));
    return LevelFin(
      stig: stig,
      image: 'assets/images/cat_skuggi-05.png',
      undertext: '\n Stig!',
      appBarText: 'Hástafir',
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

  Widget button1(double stigamet, String uid) {
    return SetScore(
      currentScoreCaps: stigamet.toStringAsFixed(0),
      level: LvlOneChoose.id,
      text: 'Borð 1: Stafir',
    );
  }

  Widget button2(double stigamet, String uid) {
    return SetScore(
      currentScoreCaps: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button3(double stigamet, String uid) {
    return SetScore(
      currentScoreCaps: stigamet.toStringAsFixed(0),
      level: Welcome.id,
      text: 'Heim',
    );
  }

  Finish finish = Finish();
  QuizBrainLvlOneVoice quizBrainLvlOneVoice = QuizBrainLvlOneVoice();
  QuizBrainLvlTwoVoice quizBrainLvlTwoVoice = QuizBrainLvlTwoVoice();
  QuizBrainLvlThreeVoice quizBrainLvlThreeVoice = QuizBrainLvlThreeVoice();
  QuizBrain quizBrain = QuizBrain();
  final formKey = GlobalKey<FormState>();

  String writePoints() {
    quizBrainLvlOneVoice.reset();
    quizBrainLvlTwoVoice.reset();
    quizBrainLvlThreeVoice.reset();
    quizBrain.reset();
    return stig.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    String highestScore = '\n Þú slóst metið þitt!';
    double stigamet = stig;
    return (BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
      if (state is IsNewRecord) {
        if (state.newRecord) {
          highestScore = '\n Þú slóst metið þitt!';
        } else {
          highestScore = '\n Metið þitt er ${state.record}';
        }
      }
      double stigamet = stig;
      return finish.FinishMethod(
        highestScore,
        stigamet,
        context,
        formKey,
        appBarText,
        image,
        stig,
        button1(stigamet, ''),
        button2(stigamet, ''),
        button3(stigamet, ''),
        cardColorCaps,
      );
    }));
  }
}

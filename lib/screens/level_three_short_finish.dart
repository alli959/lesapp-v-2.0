import 'package:Lesaforrit/models/finish_buildColumn.dart';

import 'package:Lesaforrit/screens/level_three.dart';
import 'package:Lesaforrit/screens/level_three_short.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/database/database_bloc.dart';
import '../bloc/user/authentication_bloc.dart';

import '../models/serverless/quiz_brain_lvlOne.dart';
import '../models/serverless/quiz_brain_lvlThree_Easy.dart';
import '../models/serverless/quiz_brain_lvlThree_Medium.dart';
import '../models/serverless/quiz_brain_lvlTwo_Easy.dart';
import '../models/serverless/quiz_brain_lvlTwo_Medium.dart';
import '../models/set_score.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';

import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';
import '../services/auth.dart';
import 'home/welcome.dart';
import 'lvlThree_choose.dart';
import 'lvlTwo_choose.dart';

class ThreeShortFinish extends StatelessWidget {
  ThreeShortFinish({@required this.stig});
  double stig;
  static const String id = 'ThreeShortFinish';

  @override
  Widget build(BuildContext context) {
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc
      ..add(UpdateUserScore(score: stig, typeof: 'lvlThreeEasyScore'));
    return LevelFin(
      stig: stig,
      image: 'assets/images/bear_shadow.png',
      undertext: '\n Stig!',
      appBarText: 'Stuttar setningar',
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
      currentScoreThree: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Bor?? 2: Or??',
    );
  }

  Widget button2(double stigamet, String uid) {
    return SetScore(
      currentScoreThree: stigamet.toStringAsFixed(0),
      level: LvlThreeChoose.id,
      text: 'Bor?? 3: Setningar',
    );
  }

  Widget button3(double stigamet, String uid) {
    return SetScore(
      currentScoreThree: stigamet.toStringAsFixed(0),
      level: Welcome.id,
      text: 'Heim',
    );
  }

  Finish finish = Finish();
  QuizBrainLvlOne quizBrainLvlOneCaps = QuizBrainLvlOne(true);
  QuizBrainLvlOne quizBrainLvlOne = QuizBrainLvlOne(false);
  QuizBrainLvlOneVoice quizBrainLvlOneVoice = QuizBrainLvlOneVoice();
  QuizBrainLvlTwoEasy quizBrainLvlTwoEasy = QuizBrainLvlTwoEasy();
  QuizBrainLvlTwoMedium quizBrainLvlTwoMedium = QuizBrainLvlTwoMedium();
  QuizBrainLvlTwoVoice quizBrainLvlTwoVoice = QuizBrainLvlTwoVoice();
  QuizBrainLvlThreeEasy quizBrainLvlThreeEasy = QuizBrainLvlThreeEasy();
  QuizBrainLvlThreeMedium quizBrainLvlThreeMedium = QuizBrainLvlThreeMedium();
  QuizBrainLvlThreeVoice quizBrainLvlThreeVoice = QuizBrainLvlThreeVoice();

  final formKey = GlobalKey<FormState>();

  String writePoints() {
    quizBrainLvlOneCaps.reset();
    quizBrainLvlOne.reset();
    quizBrainLvlOneVoice.reset();
    quizBrainLvlTwoEasy.reset();
    quizBrainLvlTwoMedium.reset();
    quizBrainLvlTwoVoice.reset();
    quizBrainLvlThreeEasy.reset();
    quizBrainLvlThreeMedium.reset();
    quizBrainLvlThreeVoice.reset();
    return stig.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    String highestScore = '\n ???? sl??st meti?? ??itt!';
    return (BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
      if (state is IsNewRecord) {
        if (state.newRecord) {
          highestScore = '\n ???? sl??st meti?? ??itt!';
        } else {
          highestScore = '\n Meti?? ??itt er ${state.record}';
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
        cardColorLvlThree,
      );
    }));
  }
}

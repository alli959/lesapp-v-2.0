import 'package:Lesaforrit/models/finish_buildColumn.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/wrapper.dart';
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
import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';
import '../services/auth.dart';
import 'home/welcome.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'lvlTwo_choose.dart';

class OneFinish extends StatelessWidget {
  OneFinish({@required this.stig});
  double stig;
  static const String id = 'OneFinish';

  @override
  Widget build(BuildContext context) {
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc..add(UpdateUserScore(score: stig, typeof: 'lvlOneScore'));
    return LevelFin(
      stig: stig,
      image: 'assets/images/cat_skuggi-05.png',
      undertext: '\n Stig!',
      appBarText: 'Lágstafir',
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

  Widget button1(double stigamet, DatabaseBloc databaseBloc) {
    return SetScore(
      currentScore: stigamet.toStringAsFixed(0),
      level: LvlOneChoose.id,
      text: 'Borð 1: Stafir',
    );
  }

  Widget button2(double stigamet, DatabaseBloc databaseBloc) {
    return SetScore(
      currentScore: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button3(double stigamet, DatabaseBloc databaseBloc) {
    return SetScore(
      currentScore: stigamet.toStringAsFixed(0),
      level: Wrapper.id,
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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);

    String highestScore = '\n Jei þú slóst metið þitt!';
    return BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
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
        button1(stigamet, databaseBloc),
        button2(stigamet, databaseBloc),
        button3(stigamet, databaseBloc),
        cardColor,
      );
    });
  }
}

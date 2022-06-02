import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/models/finish_buildColumn.dart';

import 'package:Lesaforrit/models/serverless/quiz_brain_lvlOne.dart';
import 'package:Lesaforrit/models/serverless/quiz_brain_lvlThree_Easy.dart';
import 'package:Lesaforrit/models/serverless/quiz_brain_lvlThree_Medium.dart';
import 'package:Lesaforrit/models/serverless/quiz_brain_lvlTwo_Medium.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user/authentication_bloc.dart';
import '../models/serverless/quiz_brain_lvlTwo_Easy.dart';
import '../models/set_score.dart';
import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';
import 'home/welcome.dart';
import 'level_three.dart';
import 'level_three_short.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';

import 'lvlThree_choose.dart';
import 'lvlTwo_choose.dart';

class ThreeVoiceFinish extends StatelessWidget {
  ThreeVoiceFinish({@required this.stig});
  double stig;
  static const String id = 'ThreeVoiceFinish';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (context) {
          final _authService = RepositoryProvider.of<AuthService>(context);
          return AuthenticationBloc(_authService)..add(GetUid());
        },
        child: LevelFin(
          stig: stig,
          image: 'assets/images/bear_shadow.png',
          undertext: '\n stig fyrir þetta borð!',
          appBarText: 'Upplesnar setningar',
        ));
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
    return BlocProvider<DatabaseBloc>(
        create: (context) {
          final _databaseService = DatabaseService(uid: uid);
          return DatabaseBloc(_databaseService)
            ..add(UpdateUserScore(score: stig, typeof: 'lvlThreeVoiceScore'));
        },
        child: SetScore(
          currentScoreThreeVoice: stigamet.toStringAsFixed(0),
          level: LvlTwoChoose.id,
          text: 'Borð 2: Orð',
        ));
  }

  Widget button2(double stigamet, String uid) {
    return BlocProvider<DatabaseBloc>(
        create: (context) {
          final _databaseService = DatabaseService(uid: uid);
          return DatabaseBloc(_databaseService)
            ..add(UpdateUserScore(score: stig, typeof: 'lvlThreeVoiceScore'));
        },
        child: SetScore(
          currentScoreThreeVoice: stigamet.toStringAsFixed(0),
          level: LvlThreeChoose.id,
          text: 'Borð 3: Setningar',
        ));
  }

  Widget button3(double stigamet, String uid) {
    return BlocProvider<DatabaseBloc>(
        create: (context) {
          final _databaseService = DatabaseService(uid: uid);
          return DatabaseBloc(_databaseService)
            ..add(UpdateUserScore(score: stig, typeof: 'lvlThreeVoiceScore'));
        },
        child: SetScore(
          currentScoreThreeVoice: stigamet.toStringAsFixed(0),
          level: Welcome.id,
          text: 'Heim',
        ));
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
    VoiceService voiceService = RepositoryProvider.of<VoiceService>(context);
    voiceService.reset();
    String highestScore = '\n Þú slóst metið þitt!';
    return (BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationLoading) {
        print("loading going on");
        return Loading();
      }
      if (state is UserUid) {
        print("UserScoreUpdate going on");
        double stigamet = stig;
        return finish.FinishMethod(
          highestScore,
          stigamet,
          context,
          formKey,
          appBarText,
          image,
          stig,
          button1(stigamet, state.uid),
          button2(stigamet, state.uid),
          button3(stigamet, state.uid),
          cardColorLvlThree,
        );
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

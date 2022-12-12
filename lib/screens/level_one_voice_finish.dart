import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/models/finish_buildColumn.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user/authentication_bloc.dart';
import '../models/set_score.dart';
import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';
import 'home/welcome.dart';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';

import 'lvlThree_choose.dart';
import 'lvlTwo_choose.dart';

class OneVoiceFinish extends StatelessWidget {
  OneVoiceFinish({@required this.stig});
  double stig;
  static const String id = 'OneVoiceFinish';

  @override
  Widget build(BuildContext context) {
    var databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc..add(UpdateUserScore(score: stig, typeof: 'lvlOneVoiceScore'));
    return LevelFin(
      stig: stig,
      image: 'assets/images/bear_shadow.png',
      undertext: '\n stig fyrir þetta borð!',
      appBarText: 'Upplesnir Stafir',
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
      currentScoreVoice: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button2(double stigamet, String uid) {
    return SetScore(
      currentScoreVoice: stigamet.toStringAsFixed(0),
      level: LvlThreeChoose.id,
      text: 'Borð 3: Setningar',
    );
  }

  Widget button3(double stigamet, String uid) {
    return SetScore(
      currentScoreVoice: stigamet.toStringAsFixed(0),
      level: Welcome.id,
      text: 'Heim',
    );
  }

  Finish finish = Finish();
  QuizBrain quizBrain = QuizBrain();
  QuizBrainLvlOneVoice quizBrainLvlOneVoice = QuizBrainLvlOneVoice();
  QuizBrainLvlTwoVoice quizBrainLvlTwoVoice = QuizBrainLvlTwoVoice();
  QuizBrainLvlThreeVoice quizBrainLvlThreeVoice = QuizBrainLvlThreeVoice();

  final formKey = GlobalKey<FormState>();

  String writePoints() {
    quizBrain.reset();
    quizBrainLvlOneVoice.reset();
    quizBrainLvlTwoVoice.reset();
    quizBrainLvlThreeVoice.reset();
    return stig.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    VoiceService voiceService = RepositoryProvider.of<VoiceService>(context);
    voiceService.reset();
    String highestScore = '\n Þú slóst metið þitt!';
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
        cardColor,
      );
    }));
  }
}

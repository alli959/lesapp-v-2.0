import 'package:Lesaforrit/models/finish_buildColumn.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlOne_cap.dart';
import 'package:Lesaforrit/screens/level_two_short.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import '../models/set_score.dart';
import 'home/welcome.dart';
import 'level_two.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/user.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'lvlOne_choose.dart';
import 'lvlTwo_choose.dart';

class TwoShortFinish extends StatelessWidget {
  TwoShortFinish({@required this.stig});
  double stig;
  static const String id = 'TwoFinish';

  @override
  Widget build(BuildContext context) {
    return LevelFin(
      stig: stig,
      image: 'assets/images/fish_skuggi-04.png',
      undertext: '\n Stig!  ',
      appBarText: 'Stutt orð',
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

  Widget button1(double stigamet) {
    return SetScore(
      currentScoreTwo: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button2(double stigamet) {
    return SetScore(
      currentScoreTwo: stigamet.toStringAsFixed(0),
      level: LvlThreeChoose.id,
      text: 'Borð 3: Setningar',
    );
  }

  Widget button3(double stigamet) {
    return SetScore(
      currentScoreTwo: stigamet.toStringAsFixed(0),
      level: Welcome.id,
      text: 'Heim',
    );
  }

  Finish finish = Finish();
  QuizBrain quizBrain = QuizBrain();
  QuizBrainOneCap quizBrainCaps = QuizBrainOneCap();
  QuizBrainLvlTwo quizBrainTwo = QuizBrainLvlTwo();
  QuizBrainLvlThree quizBrainThree = QuizBrainLvlThree();

  final formKey = GlobalKey<FormState>();

  String writePoints() {
    quizBrain.reset();
    quizBrainCaps.reset();
    quizBrainTwo.reset();
    quizBrainThree.reset();
    return stig.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    String highestScore = '\n Þú slóst metið þitt!';
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          double stigamet = stig;
          if (double.parse(userData.scoreCaps) > stigamet) {
            stigamet = double.parse(userData.scoreCaps);
            highestScore = '';
          }
          return finish.FinishMethod(
            highestScore,
            stigamet,
            context,
            formKey,
            appBarText,
            image,
            stig,
            button1(stigamet),
            button2(stigamet),
            button3(stigamet),
            cardColorLvlTwo,
          );
        }
        return Loading();
      },
    );
  }
}

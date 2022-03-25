import 'package:Lesaforrit/models/finish_buildColumn.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlOne_cap.dart';
import 'package:Lesaforrit/screens/level_three.dart';
import 'package:Lesaforrit/screens/level_three_short.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import '../models/set_score.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';

import 'home/welcome.dart';
import 'lvlThree_choose.dart';
import 'lvlTwo_choose.dart';

class ThreeShortFinish extends StatelessWidget {
  ThreeShortFinish({@required this.stig});
  double stig;
  static const String id = 'TwoFinish';

  @override
  Widget build(BuildContext context) {
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

  Widget button1(double stigamet) {
    return SetScore(
      currentScoreThree: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button2(double stigamet) {
    return SetScore(
      currentScoreThree: stigamet.toStringAsFixed(0),
      level: LvlThreeChoose.id,
      text: 'Borð 3: Setningar',
    );
  }

  Widget button3(double stigamet) {
    return SetScore(
      currentScoreThree: stigamet.toStringAsFixed(0),
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
    Usr user = Provider.of<Usr>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          double stigamet = stig;
          if (double.parse(userData.lvlThreeEasyScore) > stigamet) {
            stigamet = double.parse(userData.lvlThreeEasyScore);
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
            cardColorLvlThree,
          );
        }
        return Loading();
      },
    );
  }
}

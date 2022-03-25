import 'package:Lesaforrit/models/finish_buildColumn.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import '../models/set_score.dart';
import 'home/welcome.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo.dart';
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
    //sleep(const Duration(milliseconds: 100));
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

  Widget button1(double stigamet) {
    return SetScore(
      currentScore: stigamet.toStringAsFixed(0),
      level: LvlOneChoose.id,
      text: 'Borð 1: Stafir',
    );
  }

  Widget button2(double stigamet) {
    return SetScore(
      currentScore: stigamet.toStringAsFixed(0),
      level: LvlTwoChoose.id,
      text: 'Borð 2: Orð',
    );
  }

  Widget button3(double stigamet) {
    return SetScore(
      currentScore: stigamet.toStringAsFixed(0),
      level: Welcome.id,
      text: 'Heim',
    );
  }

  Finish finish = Finish();
  QuizBrain quizBrain = QuizBrain();
  QuizBrainLvlTwo quizBrainTwo = QuizBrainLvlTwo();
  QuizBrainLvlThree quizBrainThree = QuizBrainLvlThree();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String highestScore = '\n Jei þú slóst metið þitt!';
    Usr user = Provider.of<Usr>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          double stigamet = stig;
          if (double.parse(userData.lvlOneScore) > stigamet) {
            stigamet = double.parse(userData.lvlOneScore);
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
            cardColor,
          );
        }
        return Loading();
      },
    );
  }
}

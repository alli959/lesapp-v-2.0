import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/usr.dart';

import '../models/set_score.dart';
import 'level_one.dart';
import 'level_two.dart';

class LevelFinish extends StatelessWidget {
  LevelFinish({
    @required this.stig,
    this.image,
    this.undertext,
    this.appBarText,
  });

  double stig;
  String image;
  String undertext;
  String appBarText;

  String currentScore;
  String currentScoreTwo;
  String currentScoreThree;

  QuizBrain quizBrain = QuizBrain();
  QuizBrainLvlTwo quizBrainTwo = QuizBrainLvlTwo();
  QuizBrainLvlThree quizBrainThree = QuizBrainLvlThree();

  String highestScore = '\n Þú slóst stigametið þitt!';
  final _formKey = GlobalKey<FormState>();
  static const String id = 'levelFinish';

  String writePoints() {
    quizBrain.reset();
    quizBrainTwo.reset();
    quizBrainThree.reset();
    return stig.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    Usr user = Provider.of<Usr>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          double stigamet = stig;
          if (double.parse(userData.score) == stigamet) {
            stigamet = double.parse(userData.score);
            highestScore = 'Þú jafnaðir metið þitt!';
          }
          if (double.parse(userData.score) > stigamet) {
            stigamet = double.parse(userData.score);
            highestScore = ' Reyndu aftur til að slá metið þitt!';
          }
          return Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: cardColorLvlTwo,
                title: Text(appBarText),
              ),
              endDrawer: SideMenu(),
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      highestScore,
                      style: finishSmallText,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 90),
                      // breyta í relative..
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(image),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 45, right: 20),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: writePoints(),
                                style: TextStyle(
                                  height: 1,
                                  letterSpacing: -5,
                                  fontFamily: 'Metropolis-Medium.otf',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 100,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: undertext,
                                    style: finishSmallText,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: SetScore(
                        currentScore: stigamet.toStringAsFixed(0),
                        level: LevelOne.id,
                        text: 'Spila aftur',
                      ),
                    ),
                    Container(
                      child: SetScore(
                        currentScore: stigamet.toStringAsFixed(0),
                        level: LevelTwo.id,
                        text: 'Næsta borð',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: BottomBar(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Text('Nóbs');
      },
    );
  }
}

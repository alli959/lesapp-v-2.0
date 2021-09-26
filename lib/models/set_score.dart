import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlThree_short.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo.dart';
import 'package:Lesaforrit/models/quiz_brain_lvlTwo_short.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetScore extends StatelessWidget {
  String currentScore;
  String currentScoreCaps;
  String currentScoreTwo;
  String currentScoreTwoLong;
  String currentScoreThree;
  String currentScoreThreeLong;
  String level;
  String text;
  SetScore(
      {this.currentScore,
      this.currentScoreCaps,
      this.currentScoreTwo,
      this.currentScoreTwoLong,
      this.currentScoreThree,
      this.currentScoreThreeLong,
      this.level,
      this.text});

  static const String id = 'SetScore';
  final _formKey = GlobalKey<FormState>();
  QuizBrain quizBrain = QuizBrain();
  QuizBrainLvlTwo quizBrainTwo = QuizBrainLvlTwo();
  QuizBrainLvlTwoShort quizBrainTwoShort = QuizBrainLvlTwoShort();
  QuizBrainLvlThree quizBrainThree = QuizBrainLvlThree();
  QuizBrainLvlThreeShort quizBrainThreeShort = QuizBrainLvlThreeShort();

  String _currentName;
  String _currentAge;
  String _currentReadingStage;

  @override
  Widget build(BuildContext context) {
    Usr user = Provider.of<Usr>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //  UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: RoundedButton(
                        colour: buttonColorBlue,
                        title: text,
                        onPressed: () async {
                          quizBrain.reset();
                          quizBrainTwo.reset();
                          quizBrainTwoShort.reset();
                          quizBrainThree.reset();
                          quizBrainThreeShort.reset();

                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? snapshot.data.name,
                                currentScore ?? snapshot.data.score,
                                currentScoreCaps ?? snapshot.data.scoreCaps,
                                _currentAge ?? snapshot.data.age,
                                _currentReadingStage ??
                                    snapshot.data.readingStage,
                                currentScoreTwo ?? snapshot.data.scoreTwo,
                                currentScoreTwoLong ??
                                    snapshot.data.scoreTwoLong,
                                currentScoreThree ?? snapshot.data.scoreThree,
                                currentScoreThreeLong ??
                                    snapshot.data.scoreThreeLong);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                level, (Route<dynamic> route) => false);
                            // Navigator.pushNamed(context, level);
                          }
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

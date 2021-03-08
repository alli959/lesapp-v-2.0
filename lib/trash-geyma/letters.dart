import 'package:Lesaforrit/components/scorekeeper.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/screens/level_one_finish.dart';

import '../screens/level_one.dart';

class Letters extends StatefulWidget {
  static const String id = 'bEitt';
  @override
  _LettersState createState() => _LettersState();
}

class _LettersState extends State<Letters> {
  QuizBrain quizBrain = QuizBrain();
  Scorekeeper score = Scorekeeper();
  TotalPoints calc = TotalPoints();

  void checkAnswer(bool userPickedAnswer) {
    //Check if we've reached the end of the quiz.

    if (quizBrain.isFinished() == true) {
      score.scoreKeeper = []; // empty scorekeeper
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OneFinish(
            stig:
                (calc.calculatePoints(quizBrain.correct, quizBrain.trys)) * 100,
          ),
        ),
      );
    } else {
      if (userPickedAnswer == quizBrain.getCorrectAnswer()) {
        // Notandi  valdi  R É T T  //  C O R R E C T
        calc.correct++;
        calc.trys++;
        quizBrain.trys++;
        quizBrain.correct++;
        quizBrain.stars++;
        score.scoreKeeper.add(Icon(
          Icons.star,
          color: Colors.blue,
          size: 28,
        ));
        quizBrain.rePlay(1);
      } else {
        // Notandi valdi  R A N G T  //  F A L S E
        if (score.scoreKeeper.isNotEmpty) {
          score.scoreKeeper.removeLast();
          quizBrain.stars--;
          calc.trys++;
          quizBrain.trys++;
        } else {
          calc.trys++;
          quizBrain.trys++;
        }
        quizBrain.rePlay(2);
      }
    }
    if (quizBrain.spilari.state != AudioPlayerState.PLAYING ||
        quizBrain.player.state != AudioPlayerState.PLAYING) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ReusableCard(
            cardChild: Text(
              quizBrain.getQuestionText1(),
              style: quesText,
            ),
            onPress: () {
              quizBrain.playLocalAsset();
              checkAnswer(true);
            },
          ),
        ),
        Expanded(
          child: ReusableCard(
            cardChild: Text(
              quizBrain.getQuestionText2(),
              style: quesText,
            ),
            onPress: () {
              quizBrain.playLocalAsset();
              checkAnswer(false);
            },
          ),
        ),
      ],
    );
  }
}

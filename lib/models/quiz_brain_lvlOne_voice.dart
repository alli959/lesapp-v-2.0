import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlOne {
  // Audio audio = Audio();
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String question;
  int whichSound;
  int stars = 0;
  double finalscore;

  List<String> _questionBank = [
    'Aa',
    'Áá',
    'Bb',
    'Cc',
    'Dd',
    'Ee',
    'Éé',
    'Ff',
    'Gg',
    'Hh',
    'Ii',
    'Íí',
    'Jj',
    'Kk',
    'Ll',
    'Mm',
    'Nn',
    'Oo',
    'Óó',
    'Pp',
    'Qq',
    'Rr',
    'Ss',
    'Tt',
    'Vv',
    'Xx',
    'Yy',
    'Ýý',
    'Zz',
    'Þþ',
    'Ææ',
    'Öö'
  ];

  String getQuestionText() {
    _question = Random().nextInt(_questionBank.length - 1);
    question = _questionBank[_question];
    return question;
  }

  bool getCorrectAnswer() {
    if (whichSound == 1) return true;
    return false;
  }

  bool isFinished() {
    if (stars == 10) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    stars = 0;
    trys = 0;
    correct = 0;
    _question = 0; // kannski sleppa?
  }
}

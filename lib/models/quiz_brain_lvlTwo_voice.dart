import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlTwoVoice {
  // Audio audio = Audio();
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String question;
  int whichSound;
  int stars = 0;
  double finalscore;

  List<String> _questionBank = [
    'Að',
    'Api',
    'Ás',
    'Bæ',
    'Bú',
    'Bý',
    'Ég',
    'Ef',
    'Er',
    'Eru',
    'Fá',
    'Föt',
    'Gos',
    'Hér',
    'Kex',
    'Kú',
    'Mér',
    'Mig',
    'Nál',
    'Nú',
    'Ný',
    'Og',
    'Ör',
    'Rúm',
    'Sé',
    'Sem',
    'Sér',
    'Sig',
    'Sól',
    'Tá',
    'Tár',
    'Tær',
    'Þær',
    'Þau',
    'Þér',
    'Þú',
    'Því',
    'Til',
    'Tók',
    'Tré',
    'Upp',
    'Úr',
    'Út',
    'Var',
    'Vél',
    'Hús',
    'Rúm',
    'Hæ',
    'Ás',
    'Bál',
    'Dag',
    'Egg',
    'Eru',
    'Gær',
    'Gæs',
    'Ís',
    'Jól',
    'Kíví',
    'Kom',
    'Kýr',
    'Lax',
    'Má',
    'Mál',
    'Mús',
    'Róló',
    'Rót',
    'Sá',
    'Sem',
    'Sísí',
    'Te',
    'Þar',
    'Var',
    'Epli',
    'Gras',
    'Lamb',
    'Hús',
    'Ljós',
    'Kisa',
    'Bolli',
    'Kerti',
    'Stelpa',
    'Hjól',
    'Eðla',
    'Fluga',
    'Bíll',
    'Tölva',
    'Blár',
    'Djús',
    'Nammi',
    'Grís',
    'Glas',
    'Kaffi',
    'Fjall',
    'Snjór',
    'Húfa',
    'Augu',
    'Blóm',
    'Dreki',
    'Ungi',
    'Aftur',
    'Aldrei',
    'Allt',
    'Alltaf',
    'Baka',
    'Heim',
    'Hennar',
    'Henni',
    'Kjóll',
    'Ljón',
    'Meira',
    'Mikið',
    'Ostur',
    'Safi',
    'Saman',
    'Sími',
    'Hennar',
    'Sínum',
    'Skór',
    'Hvað',
    'Hana',
    'Varð',
    'Líka',
    'Bara',
    'Bátur',
    'Baun',
    'Fara',
    'Gæti',
    'Geit',
    'Gera',
    'Geta',
    'Grafa',
    'Gulur',
    'Hafi',
    'Hani',
    'Hans',
    'Hola',
    'Land',
    'Lauf',
    'Líka',
    'Lita',
    'Rófa',
    'Sama',
    'Síða',
    'Sjór',
    'Skip',
    'Skora',
    'Sófi',
    'Ugla',
    'Úlfur',
    'Vika',
    'Vinur',
    'Voffi',
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

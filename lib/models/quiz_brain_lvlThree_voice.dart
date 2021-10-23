import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlThree {
  // Audio audio = Audio();
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String question;
  int whichSound;
  int stars = 0;
  double finalscore;

  List<String> _questionBank = [
    'Óli fór út að hjóla',
    'Eva hoppar í polla',
    'Gult og grænt blóm',
    'Mamma fór í búðina',
    'Gunni hjólaði heim',
    'Siggi er í símanum',
    'Krakkarnir eru að leika',
    'Kisan vill fá að drekka',
    'Hundurinn gelti á kisuna',
    'Strákarnir fóru í sund',
    'Ég fékk hjól í afmælisgjöf',
    'Arna borðaði bananann',
    'Benni kann að lesa',
    'Alda er í fimleikum',
    'Villi ætlar að fara í sund',
    'Amma segir Berglindi sögu',
    'Afi og Egill fóru á hestbak',
    'Þorgeir er úti í fótbolta',
    'Ara langar í tölvu',
    'Gummi horfir á sjónvarpið',
    'Afi og Óli fóru í göngutúr',
    'Villi horfir á barnatímann',
    'Lalli fór út að hlaupa',
    'Gummi fór út að leika',
    'Elín og Alda fóru í sund',
    'Mamma og pabbi löbbuðu í búðina',
    'Kisan kom ekki heim í gær',
    'Lúlli er alltaf að veiða fiska',
    'Villi kann alla stafina',
    'Tunglið er alveg fullt',
    'Elín fékk fullt af pökkum',
    'Toggi er alltaf úti að leika',
    'Þessi bíll er mjög gamall',
    'Bóndinn á traktor og gröfu',
    'Harpa vill alltaf vera í marki',
    'Egill er duglegur að púsla',
    'Eva spilar á píanó',
    'Jóna er í ballett',
    'Afi fór í sund',
    'Mamma gaf Óla ís',
    'Anna veiddi lax',
    'Öndin borðar brauð',
    'Ari fær líka ís',
    'Gunni fór út á róló',
    'Pabbi kann að baka',
    'Voffi gelti á kisu',
    'Ég var ekki heima',
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

import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlThree {
  // Audio audio = Audio();
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();
  AudioPlayer spilari = AudioPlayer();
  int _question1 = 0;
  int _question2 = 0;
  int correct = 0;
  int trys = 0;
  String sound1;
  String sound2;
  int whichSound;
  int stars = 0;
  double finalscore;

  // H L J Ó Ð
  Future<AudioPlayer> playLocalAsset() async {
    if (whichSound == 1) {
      player = await cache.play(sound1);
      return player;
    } else {
      spilari = await cache.play(sound2);
      return spilari;
    }
  }

  void stop() async {
    if (whichSound == 1) {
      player.stop();
    } else {
      spilari.stop();
    }
  }

  List<Question> _questionBank = [
    Question('Óli fór út að hjóla', true, 'soundLevelThree/long/01.mp3'),
    Question('Eva hoppar í polla', true, 'soundLevelThree/long/02.mp3'),
    Question('Gult og grænt blóm', true, 'soundLevelThree/long/03.mp3'),
    Question('Mamma fór í búðina', true, 'soundLevelThree/long/06.mp3'),
    Question('Gunni hjólaði heim', true, 'soundLevelThree/long/07.mp3'),
    Question('Siggi er í símanum', true, 'soundLevelThree/long/09.mp3'),
    Question('Krakkarnir eru að leika', true, 'soundLevelThree/long/11.mp3'),
    Question('Kisan vill fá að drekka', true, 'soundLevelThree/long/14.mp3'),
    Question('Hundurinn gelti á kisuna', true, 'soundLevelThree/long/16.mp3'),
    Question('Strákarnir fóru í sund', true, 'soundLevelThree/long/17.mp3'),
    Question('Ég fékk hjól í afmælisgjöf', true, 'soundLevelThree/long/18.mp3'),
    Question('Arna borðaði bananann', true, 'soundLevelThree/long/22.mp3'),
    Question('Benni kann að lesa', true, 'soundLevelThree/long/24.mp3'),
    Question('Alda er í fimleikum', true, 'soundLevelThree/long/25.mp3'),
    Question('Villi ætlar að fara í sund', true, 'soundLevelThree/long/26.mp3'),
    Question('Amma segir Berglindi sögu', true, 'soundLevelThree/long/28.mp3'),
    Question(
        'Afi og Egill fóru á hestbak', true, 'soundLevelThree/long/29.mp3'),
    Question('Þorgeir er úti í fótbolta', true, 'soundLevelThree/long/31.mp3'),
    Question('Ara langar í tölvu', true, 'soundLevelThree/long/33.mp3'),
    Question('Gummi horfir á sjónvarpið', true, 'soundLevelThree/long/34.mp3'),
    Question('Afi og Óli fóru í göngutúr', true, 'soundLevelThree/long/38.mp3'),
    Question('Villi horfir á barnatímann', true, 'soundLevelThree/long/43.mp3'),
    Question('Lalli fór út að hlaupa', true, 'soundLevelThree/long/49.mp3'),
    Question('Gummi fór út að leika', true, 'soundLevelThree/long/50.mp3'),
    Question('Elín og Alda fóru í sund', true, 'soundLevelThree/long/100.mp3'),
    Question('Mamma og pabbi löbbuðu í búðina', true,
        'soundLevelThree/long/101.mp3'),
    Question('Kisan kom ekki heim í gær', true, 'soundLevelThree/long/104.mp3'),
    Question('Lúlli er alltaf að veiða fiska', true,
        'sound/levelThree/long/105.mp3'),
    Question('Villi kann alla stafina', true, 'soundLevelThree/long/107.mp3'),
    Question('Tunglið er alveg fullt', true, 'soundLevelThree/long/110.mp3'),
    Question('Elín fékk fullt af pökkum', true, 'soundLevelThree/long/113.mp3'),
    Question(
        'Toggi er alltaf úti að leika', true, 'soundLevelThree/long/114.mp3'),
    Question('Þessi bíll er mjög gamall', true, 'soundLevelThree/long/117.mp3'),
    Question(
        'Bóndinn á traktor og gröfu', true, 'soundLevelThree/long/118.mp3'),
    Question(
        'Harpa vill alltaf vera í marki', true, 'soundLevelThree/long/120.mp3'),
    Question(
        'Egill er duglegur að púsla', true, 'soundLevelThree/long/121.mp3'),
  ];

  String getQuestionText1() {
    _question1 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    sound1 = _questionBank[_question1].file;
    return _questionBank[_question1].questionText;
  }

  String getQuestionText2() {
    // þessi kóði passar bara að við fáum ekki sömu stafi. Annars er hann eins og getQuestionText1()
    _question2 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    if (_question1 == _question2) {
      _question2++;
      sound2 = _questionBank[_question2].file;
      return _questionBank[_question2].questionText;
    } else
      sound2 = _questionBank[_question2].file;
    return _questionBank[_question2].questionText;
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
    _question1 = 0; // kannski sleppa?
    _question2 = 0; // kannski sleppa?
  }
}

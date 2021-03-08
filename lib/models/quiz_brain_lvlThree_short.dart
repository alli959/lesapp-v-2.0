import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlThreeShort {
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
    Question('Lítil græn eðla', true, 'soundLevelThree/short/04.mp3'),
    Question('Ási hjólar hratt', true, 'soundLevelThree/short/05.mp3'),
    Question('Arna hljóp heim', true, 'soundLevelThree/short/08.mp3'),
    Question('Núna er rigning', true, 'soundLevelThree/short/12.mp3'),
    Question('Mikki drekkur kók', true, 'soundLevelThree/short/15.mp3'),
    Question('Klukkan er ellefu', true, 'soundLevelThree/short/19.mp3'),
    Question('Magga klappar kisu', true, 'soundLevelThree/short/30.mp3'),
    Question('Pabbi þvær þvottinn', true, 'soundLevelThree/short/40.mp3'),
    Question('Hundar gelta', true, 'soundLevelThree/short/56.mp3'),
    Question('Fuglar syngja', true, 'soundLevelThree/short/57.mp3'),
    Question('Kisur mjálma', true, 'soundLevelThree/short/58.mp3'),
    Question('Fiskurinn syndir', true, 'soundLevelThree/short/59.mp3'),
    Question('Bleikt blóm', true, 'soundLevelThree/short/61.mp3'),
    Question('Stór fluga', true, 'soundLevelThree/short/62.mp3'),
    Question('Hátt fjall', true, 'soundLevelThree/short/63.mp3'),
    Question('Amma syngur', true, 'soundLevelThree/short/65.mp3'),
    Question('Palli hjólar', true, 'soundLevelThree/short/67.mp3'),
    Question('Pabbi skrifar', true, 'soundLevelThree/short/68.mp3'),
    Question('Stórir stafir', true, 'soundLevelThree/short/69.mp3'),
    Question('Lítið ljón', true, 'soundLevelThree/short/70.mp3'),
    Question('Mikki mús', true, 'soundLevelThree/short/71.mp3'),
    Question('Stórt tré', true, 'soundLevelThree/short/72.mp3'),
    Question('Harpa les', true, 'soundLevelThree/short/73.mp3'),
    Question('Alda hlær', true, 'soundLevelThree/short/74.mp3'),
    Question('Hestar hneggja', true, 'soundLevelThree/short/75.mp3'),
    Question('Hann hljóp út', true, 'soundLevelThree/short/79.mp3'),
    Question('Henni er kalt', true, 'soundLevelThree/short/81.mp3'),
    Question('Hann er uppi', true, 'soundLevelThree/short/82.mp3'),
    Question('Hún átti hjól', true, 'soundLevelThree/short/83.mp3'),
    Question('Lambið borðar gras', true, 'soundLevelThree/short/84.mp3'),
    Question('Siggi fékk kex', true, 'soundLevelThree/short/85.mp3'),
    Question('Ávextir eru hollir', true, 'soundLevelThree/short/86.mp3'),
    Question('Fiðrildið er fallegt', true, 'soundLevelThree/short/87.mp3'),
    Question('Eva borðar pulsur', true, 'soundLevelThree/short/88.mp3'),
    Question('Ég á síma', true, 'soundLevelThree/short/89.mp3'),
    Question('Mamma les bók', true, 'soundLevelThree/short/90.mp3'),
    Question('Óli spilar á flautu', true, 'soundLevelThree/short/94.mp3'),
    Question('Traktorinn er horfinn', true, 'soundLevelThree/short/95.mp3'),
    Question('Rútan er komin', true, 'soundLevelThree/short/96.mp3'),
    Question('Nú er dimmt', true, 'soundLevelThree/short/97.mp3'),
    Question('Ása les heima', true, 'soundLevelThree/short/98.mp3'),
    Question('Máni fór út', true, 'soundLevelThree/short/99.mp3'),
    Question('Hún fór upp', true, 'soundLevelThree/short/100.mp3'),
    Question('Blómið er gult', true, 'soundLevelThree/short/101.mp3'),
    Question('Ég var ekki heima', true, 'soundLevelThree/short/102.mp3'),
    Question('Magga sá mús', true, 'soundLevelThree/short/103.mp3'),
    Question('Gæsin borðar gras', true, 'soundLevelThree/short/104.mp3'),
    Question('Músin var inni', true, 'soundLevelThree/short/105.mp3'),
    Question('Eva og Ási spila', true, 'soundLevelThree/short/107.mp3'),
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

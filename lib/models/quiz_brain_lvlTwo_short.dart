import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlTwoShort {
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
    Question('Að', true, 'soundLevelTwo/ad.mp3'),
    Question('Api', true, 'soundLevelTwo/Api.mp3'),
    Question('Ás', true, 'soundLevelTwo/as.mp3'),
    Question('Bæ', true, 'soundLevelTwo/bae.mp3'),
    Question('Bú', true, 'soundLevelTwo/buu.mp3'),
    Question('Bý', true, 'soundLevelTwo/by.mp3'),
    Question('Ég', true, 'soundLevelTwo/eeg.mp3'),
    Question('Ef', true, 'soundLevelTwo/ef.mp3'),
    Question('Er', true, 'soundLevelTwo/er.mp3'),
    Question('Eru', true, 'soundLevelTwo/eru.mp3'),
    Question('Fá', true, 'soundLevelTwo/faa.mp3'),
    Question('Föt', true, 'soundLevelTwo/foot.mp3'),
    Question('Gos', true, 'soundLevelTwo/Gos.mp3'),
    Question('Hér', true, 'soundLevelTwo/heer.mp3'),
    Question('Kex', true, 'soundLevelTwo/kex.mp3'),
    Question('Kú', true, 'soundLevelTwo/kuu.mp3'),
    Question('Mér', true, 'soundLevelTwo/mer.mp3'),
    Question('Mig', true, 'soundLevelTwo/mig.mp3'),
    Question('Nál', true, 'soundLevelTwo/naal.mp3'),
    Question('Nú', true, 'soundLevelTwo/nuu.mp3'),
    Question('Ný', true, 'soundLevelTwo/nyy.mp3'),
    Question('Og', true, 'soundLevelTwo/og.mp3'),
    Question('Ör', true, 'soundLevelTwo/oor.mp3'),
    Question('Rúm', true, 'soundLevelTwo/Rum.mp3'),
    Question('Sé', true, 'soundLevelTwo/see.mp3'),
    Question('Sem', true, 'soundLevelTwo/sem.mp3'),
    Question('Sér', true, 'soundLevelTwo/ser.mp3'),
    Question('Sig', true, 'soundLevelTwo/sig.mp3'),
    Question('Sól', true, 'soundLevelTwo/Sol.mp3'),
    Question('Tá', true, 'soundLevelTwo/taa.mp3'),
    Question('Tár', true, 'soundLevelTwo/taar.mp3'),
    Question('Tær', true, 'soundLevelTwo/taer.mp3'),
    Question('Þær', true, 'soundLevelTwo/thaer.mp3'),
    Question('Þau', true, 'soundLevelTwo/thau.mp3'),
    Question('Þér', true, 'soundLevelTwo/theer.mp3'),
    Question('Þú', true, 'soundLevelTwo/thuu.mp3'),
    Question('Því', true, 'soundLevelTwo/thvi.mp3'),
    Question('Til', true, 'soundLevelTwo/til.mp3'),
    Question('Tók', true, 'soundLevelTwo/took.mp3'),
    Question('Tré', true, 'soundLevelTwo/Tre.mp3'),
    Question('Upp', true, 'soundLevelTwo/upp.mp3'),
    Question('Úr', true, 'soundLevelTwo/uur.mp3'),
    Question('Út', true, 'soundLevelTwo/uut.mp3'),
    Question('Var', true, 'soundLevelTwo/var.mp3'),
    Question('Vél', true, 'soundLevelTwo/vel.mp3'),
    Question('Hús', true, 'soundLevelTwo/Hus.mp3'),
    Question('Rúm', true, 'soundLevelTwo/Rum.mp3'),
    Question('Hæ', true, 'soundLevelTwo/hae.mp3'),
    Question('Ás', true, 'soundLevelTwo/as.mp3'),
    Question('Bál', true, 'soundLevelTwo/bal.mp3'),
    Question('Dag', true, 'soundLevelTwo/dag.mp3'),
    Question('Egg', true, 'soundLevelTwo/egg.mp3'),
    Question('Eru', true, 'soundLevelTwo/eru.mp3'),
    Question('Gær', true, 'soundLevelTwo/gaer.mp3'),
    Question('Gæs', true, 'soundLevelTwo/gaes.mp3'),
    Question('Ís', true, 'soundLevelTwo/is.mp3'),
    Question('Jól', true, 'soundLevelTwo/jos.mp3'),
    Question('Kíví', true, 'soundLevelTwo/kivi.mp3'),
    Question('Kom', true, 'soundLevelTwo/kom.mp3'),
    Question('Kýr', true, 'soundLevelTwo/kyyr.mp3'),
    Question('Lax', true, 'soundLevelTwo/lax.mp3'),
    Question('Má', true, 'soundLevelTwo/maa.mp3'),
    Question('Mál', true, 'soundLevelTwo/maal.mp3'),
    Question('Mús', true, 'soundLevelTwo/muus.mp3'),
    Question('Róló', true, 'soundLevelTwo/rolo.mp3'),
    Question('Rót', true, 'soundLevelTwo/root.mp3'),
    Question('Sá', true, 'soundLevelTwo/sa.mp3'),
    Question('Sem', true, 'soundLevelTwo/sem.mp3'),
    Question('Sísí', true, 'soundLevelTwo/sisi.mp3'),
    Question('Te', true, 'soundLevelTwo/te.mp3'),
    Question('Þar', true, 'soundLevelTwo/thar.mp3'),
    Question('Var', true, 'soundLevelTwo/var.mp3'),
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

import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainOneCap {
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

  Future<AudioPlayer> rePlay(int which) async {
    if (which == 1) {
      player = await cache.play(sound1);
      return player;
    } else {
      player = await cache.play(sound2);
      return player;
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
    Question('A', true, 'sound/a.mp3'),
    Question('Á', true, 'sound/aa.mp3'),
    Question('B', true, 'sound/b.mp3'),
    Question('C', true, 'sound/c.mp3'),
    Question('D', true, 'sound/d.mp3'),
    Question('E', true, 'sound/e.mp3'),
    Question('É', true, 'sound/ee.mp3'),
    Question('F', true, 'sound/f.mp3'),
    Question('G', true, 'sound/g.mp3'),
    Question('H', true, 'sound/h.mp3'),
    Question('I', true, 'sound/i.mp3'),
    Question('Í', true, 'sound/ii.mp3'),
    Question('J', true, 'sound/j.mp3'),
    Question('K', true, 'sound/k.mp3'),
    Question('L', true, 'sound/l.mp3'),
    Question('M', true, 'sound/m.mp3'),
    Question('N', true, 'sound/n.mp3'),
    Question('O', true, 'sound/o.mp3'),
    Question('Ó', true, 'sound/oo.mp3'),
    Question('P', true, 'sound/p.mp3'),
    Question('Q', true, 'sound/q.mp3'),
    Question('R', true, 'sound/r.mp3'),
    Question('S', true, 'sound/s.mp3'),
    Question('T', true, 'sound/t.mp3'),
    Question('U', true, 'sound/u.mp3'),
    Question('Ú', true, 'sound/uu.mp3'),
    Question('V', true, 'sound/v.mp3'),
    Question('X', true, 'sound/x.mp3'),
    Question('Y', true, 'sound/y.mp3'),
    Question('Ý', true, 'sound/yy.mp3'),
    Question('Z', true, 'sound/z.mp3'),
    Question('Þ', true, 'sound/za.mp3'),
    Question('Æ', true, 'sound/zae.mp3'),
    Question('Ö', true, 'sound/zoe.mp3'),
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
    return false; // ef whichSound er 2
  }

  bool isFinished() {
    if (stars == 10) {
      print('FINISHED!');
      stop();
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

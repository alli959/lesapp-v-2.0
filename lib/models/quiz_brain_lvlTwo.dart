import 'question.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlTwo {
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
    Question('Epli', true, 'soundLevelTwo/long/Epli.mp3'),
    Question('Gras', true, 'soundLevelTwo/long/Gras.mp3'),
    Question('Lamb', true, 'soundLevelTwo/long/Lamb.mp3'),
    Question('Hús', true, 'soundLevelTwo/long/Hus.mp3'),
    Question('Ljós', true, 'soundLevelTwo/long/Ljos.mp3'),
    Question('Sól', true, 'soundLevelTwo/long/Sol.mp3'),
    Question('Kisa', true, 'soundLevelTwo/long/Kisa.mp3'),
    Question('Bolli', true, 'soundLevelTwo/long/Bolli.mp3'),
    Question('Kerti', true, 'soundLevelTwo/long/Kerti.mp3'),
    Question('Stelpa', true, 'soundLevelTwo/long/Stelpa.mp3'),
    Question('Hjól', true, 'soundLevelTwo/long/Hjol.mp3'),
    Question('Eðla', true, 'soundLevelTwo/long/Edla.mp3'),
    Question('Fluga', true, 'soundLevelTwo/long/Fluga.mp3'),
    Question('Bíll', true, 'soundLevelTwo/long/Bill.mp3'),
    Question('Tölva', true, 'soundLevelTwo/long/Tolva.mp3'),
    Question('Blár', true, 'soundLevelTwo/long/Blar.mp3'),
    Question('Djús', true, 'soundLevelTwo/long/Djus.mp3'),
    Question('Nammi', true, 'soundLevelTwo/long/Nammi.mp3'),
    Question('Grís', true, 'soundLevelTwo/long/Gris.mp3'),
    Question('Glas', true, 'soundLevelTwo/long/Glas.mp3'),
    Question('Kaffi', true, 'soundLevelTwo/long/Kaffi.mp3'),
    Question('Fjall', true, 'soundLevelTwo/long/Fjall.mp3'),
    Question('Snjór', true, 'soundLevelTwo/long/Snjor.mp3'),
    Question('Húfa', true, 'soundLevelTwo/long/Hufa.mp3'),
    Question('Augu', true, 'soundLevelTwo/long/Augu.mp3'),
    Question('Blóm', true, 'soundLevelTwo/long/Blom.mp3'),
    Question('Dreki', true, 'soundLevelTwo/long/Dreki.mp3'),
    Question('Ungi', true, 'soundLevelTwo/long/Ungi.mp3'),
    Question('Aftur', true, 'soundLevelTwo/long/aftur.mp3'),
    Question('Aldrei', true, 'soundLevelTwo/long/aldrei.mp3'),
    Question('Allt', true, 'soundLevelTwo/long/allt.mp3'),
    Question('Alltaf', true, 'soundLevelTwo/long/alltaf.mp3'),
    Question('Baka', true, 'soundLevelTwo/long/baka.mp3'),
    Question('Heim', true, 'soundLevelTwo/long/heim.mp3'),
    Question('Hennar', true, 'soundLevelTwo/long/hennar.mp3'),
    Question('Henni', true, 'soundLevelTwo/long/henni.mp3'),
    Question('Kjóll', true, 'soundLevelTwo/long/kjoll.mp3'),
    Question('Ljón', true, 'soundLevelTwo/long/ljon.mp3'),
    Question('Meira', true, 'soundLevelTwo/long/meira.mp3'),
    Question('Mikið', true, 'soundLevelTwo/long/mikid.mp3'),
    Question('Ostur', true, 'soundLevelTwo/long/ostur.mp3'),
    Question('Safi', true, 'soundLevelTwo/long/safi.mp3'),
    Question('Saman', true, 'soundLevelTwo/long/saman.mp3'),
    Question('Sími', true, 'soundLevelTwo/long/simi.mp3'),
    Question('Hennar', true, 'soundLevelTwo/long/hennar.mp3'),
    Question('Sínum', true, 'soundLevelTwo/long/sinum.mp3'),
    Question('Skór', true, 'soundLevelTwo/long/skor.mp3'),
    Question('Hvað', true, 'soundLevelTwo/long/hvad.mp3'),
    Question('Hana', true, 'soundLevelTwo/long/hana.mp3'),
    Question('Varð', true, 'soundLevelTwo/long/vard.mp3'),
    Question('Líka', true, 'soundLevelTwo/long/lika.mp3'),
    Question('Bara', true, 'soundLevelTwo/long/bara.mp3'),
    Question('Bátur', true, 'soundLevelTwo/long/batur.mp3'),
    Question('Baun', true, 'soundLevelTwo/long/baun.mp3'),
    Question('Fara', true, 'soundLevelTwo/long/fara.mp3'),
    Question('Gæti', true, 'soundLevelTwo/long/gaeti.mp3'),
    Question('Geit', true, 'soundLevelTwo/long/geit.mp3'),
    Question('Gera', true, 'soundLevelTwo/long/gera.mp3'),
    Question('Geta', true, 'soundLevelTwo/long/geta.mp3'),
    Question('Grafa', true, 'soundLevelTwo/long/grafa.mp3'),
    Question('Gulur', true, 'soundLevelTwo/long/gulur.mp3'),
    Question('Hafi', true, 'soundLevelTwo/long/hafi.mp3'),
    Question('Hani', true, 'soundLevelTwo/long/hani.mp3'),
    Question('Hans', true, 'soundLevelTwo/long/hans.mp3'),
    Question('Hola', true, 'soundLevelTwo/long/hola.mp3'),
    Question('Land', true, 'soundLevelTwo/long/land.mp3'),
    Question('Lauf', true, 'soundLevelTwo/long/lauf.mp3'),
    Question('Líka', true, 'soundLevelTwo/long/líka.mp3'),
    Question('Lita', true, 'soundLevelTwo/long/lita.mp3'),
    Question('Rófa', true, 'soundLevelTwo/long/rófa.mp3'),
    Question('Sama', true, 'soundLevelTwo/long/sama.mp3'),
    Question('Síða', true, 'soundLevelTwo/long/sida.mp3'),
    Question('Sjór', true, 'soundLevelTwo/long/sjor.mp3'),
    Question('Skip', true, 'soundLevelTwo/long/skip.mp3'),
    Question('Skora', true, 'soundLevelTwo/long/skora.mp3'),
    Question('Sófi', true, 'soundLevelTwo/long/sofi.mp3'),
    Question('Ugla', true, 'soundLevelTwo/long/ugla.mp3'),
    Question('Úlfur', true, 'soundLevelTwo/long/ulfur.mp3'),
    Question('Vika', true, 'soundLevelTwo/long/vika.mp3'),
    Question('Vinur', true, 'soundLevelTwo/long/vinur.mp3'),
    Question('Voffi', true, 'soundLevelTwo/long/voffi.mp3'),
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

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
    Question('Fugl', true, 'soundLevelTwo/long/Fugl.mp3'),
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
    Question('Átti', true, 'soundLevelTwo/long/aatti.mp3'),
    Question('Aðeins', true, 'soundLevelTwo/long/adeins.mp3'),
    Question('Aftur', true, 'soundLevelTwo/long/aftur.mp3'),
    Question('Aldrei', true, 'soundLevelTwo/long/aldrei.mp3'),
    Question('Allt', true, 'soundLevelTwo/long/allt.mp3'),
    Question('Alltaf', true, 'soundLevelTwo/long/alltaf.mp3'),
    Question('Annað', true, 'soundLevelTwo/long/annad.mp3'),
    Question('Baka', true, 'soundLevelTwo/long/baka.mp3'),
    Question('Bara', true, 'soundLevelTwo/long/bara.mp3'),
    Question('Börn', true, 'soundLevelTwo/long/boern.mp3'),
    Question('Dúkka', true, 'soundLevelTwo/long/dukka.mp3'),
    Question('Eins', true, 'soundLevelTwo/long/eins.mp3'),
    Question('Ekkert', true, 'soundLevelTwo/long/ekkert.mp3'),
    Question('Ekki', true, 'soundLevelTwo/long/ekki.mp3'),
    Question('Fannst', true, 'soundLevelTwo/long/fannst.mp3'),
    Question('Foss', true, 'soundLevelTwo/long/foss.mp3'),
    Question('Fram', true, 'soundLevelTwo/long/fram.mp3'),
    Question('Fyrir', true, 'soundLevelTwo/long/fyrir.mp3'),
    Question('Hæna', true, 'soundLevelTwo/long/haena.mp3'),
    Question('Hafa', true, 'soundLevelTwo/long/hafa.mp3'),
    Question('Hafi', true, 'soundLevelTwo/long/hafi.mp3'),
    Question('Hann', true, 'soundLevelTwo/long/hann.mp3'),
    Question('Hans', true, 'soundLevelTwo/long/hans.mp3'),
    Question('Hefði', true, 'soundLevelTwo/long/hefdi.mp3'),
    Question('Heim', true, 'soundLevelTwo/long/heim.mp3'),
    Question('Hennar', true, 'soundLevelTwo/long/hennar.mp3'),
    Question('Henni', true, 'soundLevelTwo/long/henni.mp3'),
    Question('Honum', true, 'soundLevelTwo/long/honum.mp3'),
    Question('Hoppa', true, 'soundLevelTwo/long/hoppa.mp3'),
    Question('Hvað', true, 'soundLevelTwo/long/hvad.mp3'),
    Question('Hvort', true, 'soundLevelTwo/long/hvort.mp3'),
    Question('Kjóll', true, 'soundLevelTwo/long/kjoll.mp3'),
    Question('Komið', true, 'soundLevelTwo/long/komid.mp3'),
    Question('Kona', true, 'soundLevelTwo/long/Kona.mp3'),
    Question('Land', true, 'soundLevelTwo/long/land.mp3'),
    Question('Lest', true, 'soundLevelTwo/long/lest.mp3'),
    Question('Líma', true, 'soundLevelTwo/long/lima.mp3'),
    Question('Lítið', true, 'soundLevelTwo/long/litid.mp3'),
    Question('Ljón', true, 'soundLevelTwo/long/ljon.mp3'),
    Question('Maður', true, 'soundLevelTwo/long/madur.mp3'),
    Question('Máni', true, 'soundLevelTwo/long/mani.mp3'),
    Question('Meira', true, 'soundLevelTwo/long/meira.mp3'),
    Question('Mikið', true, 'soundLevelTwo/long/mikid.mp3'),
    Question('Mjög', true, 'soundLevelTwo/long/mjog.mp3'),
    Question('Moli', true, 'soundLevelTwo/long/moli.mp3'),
    Question('Niður', true, 'soundLevelTwo/long/nidur.mp3'),
    Question('Nótt', true, 'soundLevelTwo/long/nott.mp3'),
    Question('Okkur', true, 'soundLevelTwo/long/okkur.mp3'),
    Question('Orðið', true, 'soundLevelTwo/long/ordid.mp3'),
    Question('Ostur', true, 'soundLevelTwo/long/ostur.mp3'),
    Question('Pera', true, 'soundLevelTwo/long/pera.mp3'),
    Question('Rófa', true, 'soundLevelTwo/long/rofa.mp3'),
    Question('Róla', true, 'soundLevelTwo/long/rola.mp3'),
    Question('Safi', true, 'soundLevelTwo/long/safi.mp3'),
    Question('Saman', true, 'soundLevelTwo/long/saman.mp3'),
    Question('Segir', true, 'soundLevelTwo/long/segir.mp3'),
    Question('Sími', true, 'soundLevelTwo/long/simi.mp3'),
    Question('Sinn', true, 'soundLevelTwo/long/sinn.mp3'),
    Question('Hennar', true, 'soundLevelTwo/long/hennar.mp3'),
    Question('Sínum', true, 'soundLevelTwo/long/sinum.mp3'),
    Question('Skoppa', true, 'soundLevelTwo/long/skoppa.mp3'),
    Question('Skór', true, 'soundLevelTwo/long/skor.mp3'),
    Question('Hvað', true, 'soundLevelTwo/long/hvad.mp3'),
    Question('Svín', true, 'soundLevelTwo/long/svin.mp3'),
    Question('Taka', true, 'soundLevelTwo/long/taka.mp3'),
    Question('Þannig', true, 'soundLevelTwo/long/thannig.mp3'),
    Question('Þegar', true, 'soundLevelTwo/long/thegar.mp3'),
    Question('Þeim', true, 'soundLevelTwo/long/theim.mp3'),
    Question('Áður', true, 'soundLevelTwo/long/adur.mp3'),
    Question('Einu', true, 'soundLevelTwo/long/einu.mp3'),
    Question('Fara', true, 'soundLevelTwo/long/fara.mp3'),
    Question('Hana', true, 'soundLevelTwo/long/hana.mp3'),
    Question('Varð', true, 'soundLevelTwo/long/vard.mp3'),
    Question('Koma', true, 'soundLevelTwo/long/koma.mp3'),
    Question('Líka', true, 'soundLevelTwo/long/lika.mp3'),
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

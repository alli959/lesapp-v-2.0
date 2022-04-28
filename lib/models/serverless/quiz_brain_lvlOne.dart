import 'dart:typed_data';

import 'package:Lesaforrit/models/question_cache.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/file.dart';

import '../question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';
import '../data.dart';
import '../../services/get_data.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'dart:convert' show utf8;

class QuizBrainLvlOne {
  String correctSound = 'sound/correct_sound.mp3';
  String incorrectSound = 'sound/incorrect_sound.mp3';
  List<Object> data = [];
  // Audio audio = Audio();
  CacheManager cookieManager;
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();
  AudioPlayer spilari = AudioPlayer();
  AudioPlayer correctPlayer = AudioPlayer();
  AudioPlayer incorrectPlayer = AudioPlayer();
  int _question1 = 0;
  int _question2 = 0;
  int correct = 0;
  int trys = 0;
  String sound1;
  String sound2;
  String sound1Secondary;
  String sound2Secondary;
  int whichSound;
  int stars = 0;
  double finalscore;
  String typeofgame = "letters";
  bool isCap;
  GetData getdata;
  bool hasInitialized = false;

  QuizBrainLvlOne(bool cap) {
    this.isCap = cap;
  }

  List<Question> _questionBank = [];
  List<QuestionCache> _questionCache = [];

  Stream<FileResponse> fileStream;
  FileResponse fileResponse;
  void addCache(List<Question> questions) async {
    for (var i = 0; i < questions.length; i++) {
      File file1 = await DefaultCacheManager().getSingleFile(questions[i].file);
      File file2 =
          await DefaultCacheManager().getSingleFile(questions[i].file2);
      QuestionCache q = QuestionCache(
          questions[i].questionText, questions[i].questionAnswer, file1, file2);
      _questionCache.add(q);
    }
  }

  // I will change the backend later, for now I will just force check it
  void addData(List<Question> questionbank) {
    if (!hasInitialized) {
      if (isCap) {
        for (var i = 0; i < questionbank.length; i++) {
          String text = questionbank[i].questionText;
          if (text.toUpperCase() == text) {
            this._questionBank.add(questionbank[i]);
          }
        }
      } else {
        for (var i = 0; i < questionbank.length; i++) {
          String text = questionbank[i].questionText;
          if (text.toLowerCase() == text) {
            this._questionBank.add(questionbank[i]);
          }
        }
      }
    }
    hasInitialized = true;
    for (var i = 0; i < _questionBank.length; i++) {
      print("questionBank letter is ${_questionBank[i].questionText}");
    }
  }
  // void getData() async {
  //   if (this.data.length > 0) {
  //     return;
  //   }
  //   this.getdata = GetData(this.typeofgame, this.typeofgamedifficulty);
  //   List<Data> data = await getdata.getData();
  //   this.data = data;

  //   for (var i = 0; i < data.length; i++) {
  //     Data value = data[i];
  //     List<int> textEncode = utf8.encode(value.Text);
  //     String textDecode = utf8.decode(textEncode);
  //     print("data Text is ${textDecode}");
  //     Question question = Question(textDecode, true, value.Dora);
  //     _questionBank.add(question);
  //   }
  // }

  Future<AudioPlayer> playCorrect() async {
    try {
      correctPlayer = await cache.play(correctSound, volume: 0.7);
      await Future.delayed(Duration(milliseconds: 1000));
      correctPlayer.stop();
    } catch (err) {
      print("there was an error playing correct sound $err");
      return null;
    }
    return null;
  }

  Future<AudioPlayer> playIncorrect() async {
    try {
      incorrectPlayer = await cache.play(incorrectSound, volume: 0.7);
      await Future.delayed(Duration(milliseconds: 1000));
      incorrectPlayer.stop();
    } catch (err) {
      print("there was an error playing correct sound");
      return null;
    }
    return null;
  }

  // Hljóð prufa

  // H L J Ó Ð
  Future<AudioPlayer> playLocalAsset() async {
    if (hasInitialized) {
      print("sound1 is $sound1");
      print("sound2 is $sound2");
      if (whichSound == 1) {
        if (sound1 == null) {
          return null;
        }
        try {
          File file1 = await DefaultCacheManager().getSingleFile(sound1);
          Uint8List bytes = file1.readAsBytesSync();
          await spilari.playBytes(bytes);
        } catch (err) {
          print("there was an error playing sound $err");
          return null;
        }
      } else {
        if (sound2 == null) {
          return null;
        }
        try {
          File file1 = await DefaultCacheManager().getSingleFile(sound2);
          Uint8List bytes = file1.readAsBytesSync();
          await spilari.playBytes(bytes);
        } catch (err) {
          print("there was an error playing sound $err");
          return null;
        }
      }
    }
    return null;
  }

  Future<AudioPlayer> playSecondaryAsset() async {
    if (hasInitialized) {
      print("sound1 secondary is $sound1Secondary");
      print("sound2 secondary is $sound2Secondary");
      if (whichSound == 1) {
        if (sound1Secondary == null) {
          return null;
        }
        try {
          File file1 =
              await DefaultCacheManager().getSingleFile(sound1Secondary);
          Uint8List bytes = file1.readAsBytesSync();
          await player.playBytes(bytes);
        } catch (err) {
          print("there was an error playing sound $err");
          return null;
        }
      } else {
        if (sound2Secondary == null) {
          return null;
        }
        try {
          File file1 =
              await DefaultCacheManager().getSingleFile(sound2Secondary);
          Uint8List bytes = file1.readAsBytesSync();
          await spilari.playBytes(bytes);
        } catch (err) {
          print("there was an error playing sound $err");
          return null;
        }
      }
    }
    return null;
  }

  Future<AudioPlayer> playKarl() async {
    if (hasInitialized) {
      print("sound1 is $sound1");
      print("sound1Secondary is $sound1Secondary");
      print("sound2 is $sound2");
      print("sound2Secondary is $sound2Secondary");
      if (whichSound == 1) {
        if (sound1 == null) {
          return null;
        }
        var sound1FileEnding = sound1.split('_')[1];
        if (sound1FileEnding == 'Karl.mp3') {
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound1);
            Uint8List bytes = file1.readAsBytesSync();
            await player.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          try {
            File file1 =
                await DefaultCacheManager().getSingleFile(sound1Secondary);
            Uint8List bytes = file1.readAsBytesSync();
            await player.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        }
      } else {
        var sound2FileEnding = sound2.split('_')[1];
        if (sound2FileEnding == 'Karl.mp3') {
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound2);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          try {
            File file1 =
                await DefaultCacheManager().getSingleFile(sound2Secondary);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        }
      }
    }
    return null;
  }

  Future<AudioPlayer> playDora() async {
    if (hasInitialized) {
      print("sound1 is $sound1");
      print("sound1Secondary is $sound1Secondary");
      print("sound2 is $sound2");
      print("sound2 is $sound2Secondary");
      if (whichSound == 1) {
        if (sound1 == null) {
          return null;
        }
        var sound1FileEnding = sound1.split('_')[1];
        if (sound1FileEnding == 'Dora.mp3') {
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound1);
            Uint8List bytes = file1.readAsBytesSync();
            await player.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          try {
            File file1 =
                await DefaultCacheManager().getSingleFile(sound1Secondary);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        }
      } else {
        var sound2FileEnding = sound2.split('_')[1];
        if (sound2FileEnding == 'Dora.mp3') {
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound2);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          try {
            File file1 =
                await DefaultCacheManager().getSingleFile(sound2Secondary);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        }
      }
    }
    return null;
  }

  void stop() async {
    if (whichSound == 1) {
      player.stop();
    } else {
      spilari.stop();
    }
  }

  // List<Question> _questionBank = [
  //   Question('Lítil græn eðla', true, 'soundLevelThree/short/04.mp3'),
  //   Question('Ási hjólar hratt', true, 'soundLevelThree/short/05.mp3'),
  //   Question('Arna hljóp heim', true, 'soundLevelThree/short/08.mp3'),
  //   Question('Núna er rigning', true, 'soundLevelThree/short/12.mp3'),
  //   Question('Mikki drekkur kók', true, 'soundLevelThree/short/15.mp3'),
  //   Question('Klukkan er ellefu', true, 'soundLevelThree/short/19.mp3'),
  //   Question('Magga klappar kisu', true, 'soundLevelThree/short/30.mp3'),
  //   Question('Pabbi þvær þvottinn', true, 'soundLevelThree/short/40.mp3'),
  //   Question('Hundar gelta', true, 'soundLevelThree/short/56.mp3'),
  //   Question('Fuglar syngja', true, 'soundLevelThree/short/57.mp3'),
  //   Question('Kisur mjálma', true, 'soundLevelThree/short/58.mp3'),
  //   Question('Fiskurinn syndir', true, 'soundLevelThree/short/59.mp3'),
  //   Question('Bleikt blóm', true, 'soundLevelThree/short/61.mp3'),
  //   Question('Stór fluga', true, 'soundLevelThree/short/62.mp3'),
  //   Question('Hátt fjall', true, 'soundLevelThree/short/63.mp3'),
  //   Question('Amma syngur', true, 'soundLevelThree/short/65.mp3'),
  //   Question('Palli hjólar', true, 'soundLevelThree/short/67.mp3'),
  //   Question('Pabbi skrifar', true, 'soundLevelThree/short/68.mp3'),
  //   Question('Stórir stafir', true, 'soundLevelThree/short/69.mp3'),
  //   Question('Lítið ljón', true, 'soundLevelThree/short/70.mp3'),
  //   Question('Mikki mús', true, 'soundLevelThree/short/71.mp3'),
  //   Question('Stórt tré', true, 'soundLevelThree/short/72.mp3'),
  //   Question('Harpa les', true, 'soundLevelThree/short/73.mp3'),
  //   Question('Alda hlær', true, 'soundLevelThree/short/74.mp3'),
  //   Question('Hestar hneggja', true, 'soundLevelThree/short/75.mp3'),
  //   Question('Hann hljóp út', true, 'soundLevelThree/short/79.mp3'),
  //   Question('Henni er kalt', true, 'soundLevelThree/short/81.mp3'),
  //   Question('Hann er uppi', true, 'soundLevelThree/short/82.mp3'),
  //   Question('Hún átti hjól', true, 'soundLevelThree/short/83.mp3'),
  //   Question('Lambið borðar gras', true, 'soundLevelThree/short/84.mp3'),
  //   Question('Siggi fékk kex', true, 'soundLevelThree/short/85.mp3'),
  //   Question('Ávextir eru hollir', true, 'soundLevelThree/short/86.mp3'),
  //   Question('Fiðrildið er fallegt', true, 'soundLevelThree/short/87.mp3'),
  //   Question('Eva borðar pulsur', true, 'soundLevelThree/short/88.mp3'),
  //   Question('Ég á síma', true, 'soundLevelThree/short/89.mp3'),
  //   Question('Mamma les bók', true, 'soundLevelThree/short/90.mp3'),
  //   Question('Óli spilar á flautu', true, 'soundLevelThree/short/94.mp3'),
  //   Question('Traktorinn er horfinn', true, 'soundLevelThree/short/95.mp3'),
  //   Question('Rútan er komin', true, 'soundLevelThree/short/96.mp3'),
  //   Question('Nú er dimmt', true, 'soundLevelThree/short/97.mp3'),
  //   Question('Ása les heima', true, 'soundLevelThree/short/98.mp3'),
  //   Question('Máni fór út', true, 'soundLevelThree/short/99.mp3'),
  //   Question('Hún fór upp', true, 'soundLevelThree/short/100.mp3'),
  //   Question('Blómið er gult', true, 'soundLevelThree/short/101.mp3'),
  //   Question('Magga sá mús', true, 'soundLevelThree/short/103.mp3'),
  //   Question('Gæsin borðar gras', true, 'soundLevelThree/short/104.mp3'),
  //   Question('Músin var inni', true, 'soundLevelThree/short/105.mp3'),
  //   Question('Eva og Ási spila', true, 'soundLevelThree/short/107.mp3'),
  // ];

  String getQuestionText1() {
    _question1 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    sound1 = _questionBank[_question1].file;
    sound1Secondary = _questionBank[_question1].file2;
    return _questionBank[_question1].questionText;
  }

  String getQuestionText2() {
    // þessi kóði passar bara að við fáum ekki sömu stafi. Annars er hann eins og getQuestionText1()
    _question2 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    if (_question1 == _question2) {
      _question2++;
      sound2 = _questionBank[_question2].file;
      sound2Secondary = _questionBank[_question2].file2;
      return _questionBank[_question2].questionText;
    } else {
      sound2 = _questionBank[_question2].file;
      sound2Secondary = _questionBank[_question2].file2;
    }
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

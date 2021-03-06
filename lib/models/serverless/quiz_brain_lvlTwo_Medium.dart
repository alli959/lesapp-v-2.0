import 'dart:typed_data';

import 'package:flutter_cache_manager/file.dart';

import '../PrefVoice.dart';
import '../question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';
import '../data.dart';
import '../../services/get_data.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:io' show Platform;

import 'dart:convert' show utf8;

import '../question_cache.dart';

class QuizBrainLvlTwoMedium {
  String correctSound = 'sound/correct_sound.mp3';
  String incorrectSound = 'sound/incorrect_sound.mp3';
  List<Object> data = [];
  // Audio audio = Audio();
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
  String typeofgame = "words";
  String typeofgamedifficulty = "medium";
  GetData getdata;
  bool hasInitialized = false;
  List<Question> _questionBank = [
    Question('Epli', true, 'soundLevelTwo/long/Epli.mp3'),
    Question('Gras', true, 'soundLevelTwo/long/Gras.mp3'),
  ];

  List<QuestionCache> _questionCache = [];

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

  void addData(List<Question> questionbank) {
    this._questionBank = questionbank;
    hasInitialized = true;
  }

  Future<AudioPlayer> playCorrect() async {
    try {
      correctPlayer = await cache.play(correctSound, volume: 0.2);
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
      incorrectPlayer = await cache.play(incorrectSound, volume: 0.2);
      await Future.delayed(Duration(milliseconds: 1000));
      incorrectPlayer.stop();
    } catch (err) {
      print("there was an error playing correct sound");
      return null;
    }
    return null;
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

  // Hlj???? prufa

  // H L J ?? ??
  Future<AudioPlayer> playLocalAsset() async {
    if (hasInitialized) {
      print("sound1 is $sound1");
      print("sound2 is $sound2");
      if (whichSound == 1) {
        if (sound1 == null) {
          return null;
        }
        if (!Platform.isAndroid) {
          try {
            spilari.play(sound1, isLocal: false);
            return null;
          } catch (err) {
            print("there was an error playing sound ${sound1}");
            return null;
          }
        }
        try {
          File file1 = await DefaultCacheManager().getSingleFile(sound1);
          print("file is $file1");
          Uint8List bytes = file1.readAsBytesSync();
          print("length if bytes is ${bytes.length}");
          print("bytes is $bytes");

          await spilari.playBytes(bytes);
        } catch (err) {
          print("there was an error playing sound $err");
          return null;
        }
      } else {
        if (sound2 == null) {
          return null;
        }
        if (!Platform.isAndroid) {
          try {
            spilari.play(sound2, isLocal: false);
            return null;
          } catch (err) {
            print("there was an error playing sound ${sound2}");
            return null;
          }
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
        if (!Platform.isAndroid) {
          try {
            player.play(sound1Secondary, isLocal: false);
            return null;
          } catch (err) {
            print("there was an error playing sound ${sound1}");
            return null;
          }
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
        if (!Platform.isAndroid) {
          try {
            spilari.play(sound2Secondary, isLocal: false);
            return null;
          } catch (err) {
            print("there was an error playing sound ${sound2Secondary}");
            return null;
          }
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
          if (!Platform.isAndroid) {
            try {
              player.play(sound1, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound1}");
              return null;
            }
          }
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound1);
            Uint8List bytes = file1.readAsBytesSync();
            await player.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          if (!Platform.isAndroid) {
            try {
              player.play(sound1Secondary, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound1Secondary}");
              return null;
            }
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
        }
      } else {
        var sound2FileEnding = sound2.split('_')[1];
        if (sound2FileEnding == 'Karl.mp3') {
          if (!Platform.isAndroid) {
            try {
              spilari.play(sound2, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound2}");
              return null;
            }
          }
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound2);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          if (!Platform.isAndroid) {
            try {
              spilari.play(sound2Secondary, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound2Secondary}");
              return null;
            }
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
          if (!Platform.isAndroid) {
            try {
              player.play(sound1, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound1}");
              return null;
            }
          }
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound1);
            Uint8List bytes = file1.readAsBytesSync();
            await player.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          if (!Platform.isAndroid) {
            try {
              spilari.play(sound1Secondary, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound1}");
              return null;
            }
          }
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
          if (!Platform.isAndroid) {
            try {
              spilari.play(sound2, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound2}");
              return null;
            }
          }
          try {
            File file1 = await DefaultCacheManager().getSingleFile(sound2);
            Uint8List bytes = file1.readAsBytesSync();
            await spilari.playBytes(bytes);
          } catch (err) {
            print("there was an error playing sound $err");
            return null;
          }
        } else {
          if (!Platform.isAndroid) {
            try {
              spilari.play(sound2Secondary, isLocal: false);
              return null;
            } catch (err) {
              print("there was an error playing sound ${sound2Secondary}");
              return null;
            }
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
  //   Question('L??til gr??n e??la', true, 'soundLevelThree/short/04.mp3'),
  //   Question('??si hj??lar hratt', true, 'soundLevelThree/short/05.mp3'),
  //   Question('Arna hlj??p heim', true, 'soundLevelThree/short/08.mp3'),
  //   Question('N??na er rigning', true, 'soundLevelThree/short/12.mp3'),
  //   Question('Mikki drekkur k??k', true, 'soundLevelThree/short/15.mp3'),
  //   Question('Klukkan er ellefu', true, 'soundLevelThree/short/19.mp3'),
  //   Question('Magga klappar kisu', true, 'soundLevelThree/short/30.mp3'),
  //   Question('Pabbi ??v??r ??vottinn', true, 'soundLevelThree/short/40.mp3'),
  //   Question('Hundar gelta', true, 'soundLevelThree/short/56.mp3'),
  //   Question('Fuglar syngja', true, 'soundLevelThree/short/57.mp3'),
  //   Question('Kisur mj??lma', true, 'soundLevelThree/short/58.mp3'),
  //   Question('Fiskurinn syndir', true, 'soundLevelThree/short/59.mp3'),
  //   Question('Bleikt bl??m', true, 'soundLevelThree/short/61.mp3'),
  //   Question('St??r fluga', true, 'soundLevelThree/short/62.mp3'),
  //   Question('H??tt fjall', true, 'soundLevelThree/short/63.mp3'),
  //   Question('Amma syngur', true, 'soundLevelThree/short/65.mp3'),
  //   Question('Palli hj??lar', true, 'soundLevelThree/short/67.mp3'),
  //   Question('Pabbi skrifar', true, 'soundLevelThree/short/68.mp3'),
  //   Question('St??rir stafir', true, 'soundLevelThree/short/69.mp3'),
  //   Question('L??ti?? lj??n', true, 'soundLevelThree/short/70.mp3'),
  //   Question('Mikki m??s', true, 'soundLevelThree/short/71.mp3'),
  //   Question('St??rt tr??', true, 'soundLevelThree/short/72.mp3'),
  //   Question('Harpa les', true, 'soundLevelThree/short/73.mp3'),
  //   Question('Alda hl??r', true, 'soundLevelThree/short/74.mp3'),
  //   Question('Hestar hneggja', true, 'soundLevelThree/short/75.mp3'),
  //   Question('Hann hlj??p ??t', true, 'soundLevelThree/short/79.mp3'),
  //   Question('Henni er kalt', true, 'soundLevelThree/short/81.mp3'),
  //   Question('Hann er uppi', true, 'soundLevelThree/short/82.mp3'),
  //   Question('H??n ??tti hj??l', true, 'soundLevelThree/short/83.mp3'),
  //   Question('Lambi?? bor??ar gras', true, 'soundLevelThree/short/84.mp3'),
  //   Question('Siggi f??kk kex', true, 'soundLevelThree/short/85.mp3'),
  //   Question('??vextir eru hollir', true, 'soundLevelThree/short/86.mp3'),
  //   Question('Fi??rildi?? er fallegt', true, 'soundLevelThree/short/87.mp3'),
  //   Question('Eva bor??ar pulsur', true, 'soundLevelThree/short/88.mp3'),
  //   Question('??g ?? s??ma', true, 'soundLevelThree/short/89.mp3'),
  //   Question('Mamma les b??k', true, 'soundLevelThree/short/90.mp3'),
  //   Question('??li spilar ?? flautu', true, 'soundLevelThree/short/94.mp3'),
  //   Question('Traktorinn er horfinn', true, 'soundLevelThree/short/95.mp3'),
  //   Question('R??tan er komin', true, 'soundLevelThree/short/96.mp3'),
  //   Question('N?? er dimmt', true, 'soundLevelThree/short/97.mp3'),
  //   Question('??sa les heima', true, 'soundLevelThree/short/98.mp3'),
  //   Question('M??ni f??r ??t', true, 'soundLevelThree/short/99.mp3'),
  //   Question('H??n f??r upp', true, 'soundLevelThree/short/100.mp3'),
  //   Question('Bl??mi?? er gult', true, 'soundLevelThree/short/101.mp3'),
  //   Question('Magga s?? m??s', true, 'soundLevelThree/short/103.mp3'),
  //   Question('G??sin bor??ar gras', true, 'soundLevelThree/short/104.mp3'),
  //   Question('M??sin var inni', true, 'soundLevelThree/short/105.mp3'),
  //   Question('Eva og ??si spila', true, 'soundLevelThree/short/107.mp3'),
  // ];

  String getQuestionText1() {
    _question1 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    Question questionOne = _questionBank[_question1];
    if (questionOne.prefVoice == PrefVoice.DORA) {
      sound1 = questionOne.file;
      sound1Secondary = questionOne.file2;
    } else {
      sound1 = questionOne.file2;
      sound1Secondary = questionOne.file;
    }
    return _questionBank[_question1].questionText;
  }

  String getQuestionText2() {
    // ??essi k????i passar bara a?? vi?? f??um ekki s??mu stafi. Annars er hann eins og getQuestionText1()
    _question2 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;

    if (_question1 == _question2) {
      _question2++;
    }
    Question questionTwo = _questionBank[_question2];
    if (questionTwo.prefVoice == PrefVoice.DORA) {
      sound2 = questionTwo.file;
      sound2Secondary = questionTwo.file2;
    } else {
      sound2 = questionTwo.file2;
      sound2Secondary = questionTwo.file;
    }

    return questionTwo.questionText;
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

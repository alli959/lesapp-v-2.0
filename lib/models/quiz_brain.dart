import 'dart:async';
import 'dart:math';

import 'package:Lesaforrit/models/ModelProvider.dart';
import 'package:Lesaforrit/models/question_cache.dart';
import 'package:Lesaforrit/services/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import './PrefVoice.dart';
import './question.dart';
import '../../services/get_data.dart';

class QuizBrain {
  final String correctSound = 'assets/sound/correct_sound.mp3';
  final String incorrectSound = 'assets/sound/incorrect_sound.mp3';
  final AudioCache cache = AudioCache();
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer spilari = AudioPlayer();
  final AudioPlayer correctPlayer = AudioPlayer();
  final AudioPlayer incorrectPlayer = AudioPlayer();
  final List<Object> data = [];
  final List<Question> _questionBank = [];
  final List<QuestionCache> _questionCache = [];

  int _question1 = 0;
  int _question2 = 0;
  int correct = 0;
  int trys = 0;
  int stars = 0;
  int? whichSound;
  bool? isCap;
  bool? hasInitialized = false;
  String? sound1;
  String? sound2;
  String? sound1Secondary;
  String? sound2Secondary;
  String? typeofgame;
  String? typeofgamedifficulty;

  AudioSessionService? audioSessionService;
  GetData? getdata;

  QuizBrain({
    this.typeofgame,
    this.typeofgamedifficulty,
    this.isCap = true,
  });

  void addCache(List<Question> questions) async {
    for (Question question in questions) {
      File file1 = await DefaultCacheManager().getSingleFile(question.file);
      File file2 = await DefaultCacheManager()
          .getSingleFile(question.file2 ?? question.file);
      QuestionCache q = QuestionCache(
          question.questionText, question.questionAnswer, file1, file2);
      _questionCache.add(q);
    }
  }

  void addData(List<Question> questionbank,
      [bool? isCapParam,
      String? typeOfGameParam,
      String? typeOfDifficultyParam,
      AudioSessionService? _audioSessionServiceParam]) {
    audioSessionService = _audioSessionServiceParam!;
    typeofgame = typeOfGameParam!;
    isCap = isCapParam ?? true;

    if (typeOfDifficultyParam == "cap") {
      isCap = true;
    } else if (typeOfDifficultyParam == "low") {
      isCap = false;
    }
    typeofgamedifficulty = typeOfDifficultyParam!;

    if (typeofgame == "letters" && !hasInitialized!) {
      if (isCap == true) {
        _questionBank.addAll(questionbank
            .where((q) => q.questionText.toUpperCase() == q.questionText));
      } else {
        _questionBank.addAll(questionbank
            .where((q) => q.questionText.toLowerCase() == q.questionText));
      }
      hasInitialized = true;
    } else {
      _questionBank.addAll(questionbank);
      hasInitialized = true;
    }
  }

  Future<AudioPlayer?> playCorrect() async {
    try {
      await audioSessionService?.setPlayerLocalUrl(correctSound, 70);
      await Future.delayed(Duration(milliseconds: 1000));
      audioSessionService?.play();
    } catch (err) {
      print("Error playing correct sound: $err");
      return null;
    }
    return null;
  }

  Future<AudioPlayer?> playIncorrect() async {
    try {
      await audioSessionService?.setPlayerLocalUrl(incorrectSound, 250);
      await Future.delayed(Duration(milliseconds: 1000));
      audioSessionService?.play();
    } catch (err) {
      print("Error playing incorrect sound");
      return null;
    }
    return null;
  }

  Future<AudioPlayer?> _playSound(String sound, String secondarySound) async {
    if (hasInitialized == true) {
      var soundFileEnding = sound.split('_')[1];
      String soundToPlay =
          (soundFileEnding == 'Dora.mp3' || soundFileEnding == 'Karl.mp3')
              ? sound
              : secondarySound;
      try {
        await audioSessionService?.setPlayerUrl(soundToPlay);
        audioSessionService?.play();
      } catch (err) {
        print("Error playing sound: $err");
        return null;
      }
    }
    return null;
  }

  Future<AudioPlayer?> playKarl() => _playSound(sound1!, sound1Secondary!);

  Future<AudioPlayer?> playDora() => _playSound(sound2!, sound2Secondary!);

  void stop() {
    if (whichSound == 1) {
      player.stop();
    } else {
      spilari.stop();
    }
  }

  String getQuestionText1() {
    _question1 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    Question questionOne = _questionBank[_question1];
    sound1 = (questionOne.prefVoice == PrefVoice.DORA)
        ? questionOne.file
        : questionOne.file2;
    sound1Secondary = (questionOne.prefVoice == PrefVoice.DORA)
        ? questionOne.file2
        : questionOne.file;
    return questionOne.questionText;
  }

  String getQuestionText2() {
    _question2 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;

    if (_question1 == _question2) {
      _question2++;
    }
    Question questionTwo = _questionBank[_question2];
    sound2 = (questionTwo.prefVoice == PrefVoice.DORA)
        ? questionTwo.file
        : questionTwo.file2;
    sound2Secondary = (questionTwo.prefVoice == PrefVoice.DORA)
        ? questionTwo.file2
        : questionTwo.file;

    return questionTwo.questionText;
  }

  bool getCorrectAnswer() => whichSound == 1;

  bool isFinished() => stars == 10;

  void reset() {
    stars = 0;
    trys = 0;
    correct = 0;
    _question1 = 0;
    _question2 = 0;
  }

  void playLocalAsset() {
    if (whichSound == 1) {
      AssetSource source = AssetSource(sound1!);
      player.play(source);
    } else {
      AssetSource source = AssetSource(sound2!);
      player.play(source);
    }
  }
}

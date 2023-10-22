import 'dart:async';
import 'dart:math';

import 'package:Lesaforrit/services/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import './PrefVoice.dart';
import './question.dart';
import 'question_cache.dart';

class QuizBrain {
  static const String CORRECT_SOUND_PATH = 'assets/sound/correct_sound.mp3';
  static const String INCORRECT_SOUND_PATH = 'assets/sound/incorrect_sound.mp3';
  static const int CORRECT_SOUND_VOLUME = 70;
  static const int INCORRECT_SOUND_VOLUME = 250;

  final AudioPlayer player = AudioPlayer();

  final List<Question> _questionBank = [];
  final List<QuestionCache> _questionCache = [];
  bool isLoading = false;

  int _question1 = 0;
  int _question2 = 0;
  int correct = 0;
  int trys = 0;
  int stars = 0;
  int? whichSound;
  bool? isCap;
  bool? hasInitialized = false;
  String? typeofgame;
  String? typeofgamedifficulty;

  String? soundDoraTop;
  String? soundDoraBottom;
  String? soundKarlTop;
  String? soundKarlBottom;

  AudioSessionService? audioSessionService;

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

  Future<void> preloadAudio(String audioUrl) async {
    isLoading = true;
    try {
      await player.setPlayerMode(PlayerMode.lowLatency);
      await player.setSource(UrlSource(audioUrl)); // Preload the audio
    } catch (e) {
      print("Error preloading audio: $e");
    } finally {
      print("Done preloading audio");
      isLoading = false; // Reset loading state
    }
  }

  Future<void> playAudioWithPreload(String audioUrl) async {
    await preloadAudio(audioUrl); // Preload the audio
    try {
      await player.play(UrlSource(audioUrl)); // Play once preloaded
    } catch (e) {
      print("Error playing audio after preload: $e");
    }
  }

  Future<void> playCorrect() async {
    isLoading = true;
    try {
      await player.release(); // <-- Release the player here
      await audioSessionService?.setPlayerLocalUrl(CORRECT_SOUND_PATH);
      audioSessionService?.play();
    } catch (err) {
      print("Error playing correct sound: $err");
    } finally {
      isLoading = false;
    }
  }

  Future<AudioPlayer?> playIncorrect() async {
    isLoading = true;
    try {
      await player.release(); // <-- Release the player here
      await audioSessionService?.setPlayerLocalUrl(INCORRECT_SOUND_PATH);
      audioSessionService?.play();
    } catch (err) {
      print("Error playing incorrect sound: $err");
      return null;
    } finally {
      isLoading = false;
    }
    return null;
  }

  Future<void> playDora() async {
    try {
      await player.release(); // <-- Release the player here
      String soundToPlay = whichSound == 1 ? soundDoraTop! : soundDoraBottom!;
      await playAudioWithPreload(
          soundToPlay); // Use new method to preload then play
    } catch (err) {
      print("Error playing Dora's sound: $err");
    }
  }

  Future<void> playKarl() async {
    try {
      await player.release(); // <-- Release the player here
      String soundToPlay = whichSound == 1 ? soundKarlTop! : soundKarlBottom!;
      await playAudioWithPreload(
          soundToPlay); // Use new method to preload then play
    } catch (err) {
      print("Error playing Karl's sound: $err");
    }
  }

  void stop() {
    player.stop();
  }

  String getQuestionText1() {
    _question1 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;
    Question questionOne = _questionBank[_question1];
    soundDoraTop =
        questionOne.file; // Assuming file always contains Dora's sound
    soundKarlTop = questionOne.file2 ??
        questionOne.file; // Assuming file2 always contains Karl's sound
    return questionOne.questionText;
  }

  String getQuestionText2() {
    _question2 = Random().nextInt(_questionBank.length - 1);
    whichSound = Random().nextInt(2) + 1;

    // Ensure _question2 is not equal to _question1
    while (_question1 == _question2) {
      _question2 = Random().nextInt(_questionBank.length - 1);
    }

    Question questionTwo = _questionBank[_question2];
    print("questionTwo is $questionTwo");
    soundDoraBottom =
        questionTwo.file; // Assuming file always contains Dora's sound
    soundKarlBottom = questionTwo.file2 ??
        questionTwo.file; // Assuming file2 always contains Karl's sound

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
    player.release(); // <-- Release the player here
    if (whichSound == 1) {
      AssetSource source = AssetSource(soundDoraTop!);
      player.play(source);
    } else {
      AssetSource source = AssetSource(soundDoraBottom!);
      player.play(source);
    }
  }
}

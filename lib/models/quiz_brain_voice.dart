import 'package:Lesaforrit/services/audio_session.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import './question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'PrefVoice.dart';

class QuizBrainVoice {
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String? question;
  int? whichSound;
  int stars = 0;
  double? finalscore;
  AudioCache cache = AudioCache();
  String correctSound = 'assets/sound/correct_sound.mp3';
  String incorrectSound = 'sound/incorrect_sound.mp3';
  AudioPlayer correctPlayer = AudioPlayer();
  AudioPlayer incorrectPlayer = AudioPlayer();
  bool isCap;
  String? typeofgame;
  String? typeofgamedifficulty;
  bool hasInitialized = false;
  AudioSessionService? audioSessionService;
  List<Question> _questionBank = [];
  PrefVoice prefVoice = PrefVoice.DORA;

  QuizBrainVoice(
      {this.typeofgame, this.typeofgamedifficulty, this.isCap = true});

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
    Question currentQuestion = _questionBank[_question];
    String file = currentQuestion.file;
    String? file2 = currentQuestion.file2;
    prefVoice = currentQuestion.prefVoice;

    if (hasInitialized) {
      String chosenFile = (prefVoice == PrefVoice.DORA) ? file : file2 ?? file;
      try {
        await audioSessionService?.setPlayerUrl(chosenFile);
        audioSessionService?.play();
      } catch (err) {
        print("Error playing sound: $chosenFile");
        return null;
      }
    }
    return null;
  }

  void addData(List<Question> questionbank, String typeofgame,
      String difficulty, AudioSessionService _audioSessionServiceParam) {
    this.audioSessionService = _audioSessionServiceParam;
    this.typeofgame = typeofgame;
    this.typeofgamedifficulty = typeofgamedifficulty;

    if (this.typeofgame == "letters" && !hasInitialized) {
      for (var i = 0; i < questionbank.length; i++) {
        Question question = questionbank[i];
        String text = question.questionText;
        text = text.toUpperCase() + text.toLowerCase();
        question.setQuestionText(text);
        this._questionBank.add(question);
      }
      hasInitialized = true;
    } else {
      this._questionBank = questionbank;
      hasInitialized = true;
    }
  }

  String getQuestionText() {
    _question = Random().nextInt(_questionBank.length - 1);
    question = _questionBank[_question].questionText;
    return question ?? "";
  }

  dynamic bestLastWord(
      String lWords, String quest, List<SpeechRecognitionAlternative> alt) {
    int closestVal = lWords.toLowerCase().compareTo(quest.toLowerCase());
    int closestIndex = -1;

    for (int i = 0; i < alt.length; i++) {
      String tempString = alt[i].transcript.trim();
      int temp = tempString.toLowerCase().compareTo(quest.toLowerCase());
      if (temp.abs() < closestVal.abs()) {
        closestIndex = i;
        closestVal = temp;
      }
    }

    return (closestIndex == -1) ? lWords : alt[closestIndex].transcript;
  }

  Map<String, Object> isCorrect(
      String userVoiceAnswer, String question, String lvl) {
    if (lvl == "level_1" &&
        question[0].substring(0, 1).toLowerCase() ==
            userVoiceAnswer[0].substring(0, 1).toLowerCase()) {
      userVoiceAnswer = question;
    }

    int totalCorrect = 0;
    int totalIncorrect = 0;
    List<String> questionArr = question.split(' ');
    List<String> answerArr = userVoiceAnswer.split(' ');
    Map<String, int> mapQuestion = _createMap(questionArr);
    Map<String, int> mapAnswer = _createMap(answerArr);
    List<bool> questionMap =
        _createColorBoard(questionArr, mapAnswer, totalCorrect, totalIncorrect);
    List<bool> answerMap =
        _createColorBoard(answerArr, mapQuestion, totalCorrect, totalIncorrect);

    double points = totalCorrect / (totalCorrect + totalIncorrect);

    return {
      "points": points,
      "correct": totalCorrect,
      "questionMap": questionMap,
      "answerMap": answerMap,
      "questionArr": questionArr,
      "answerArr": answerArr
    };
  }

  Map<String, int> _createMap(List<String> list) {
    Map<String, int> map = {};
    for (var item in list) {
      map[item.toLowerCase()] = map.containsKey(item.toLowerCase())
          ? map[item.toLowerCase()]! + 1
          : 1;
    }
    return map;
  }

  List<bool> _createColorBoard(List<String> list, Map<String, int> map,
      int totalCorrect, int totalIncorrect) {
    List<bool> colorBoard = [];
    for (var item in list) {
      if (map.containsKey(item.toLowerCase())) {
        totalCorrect += 1;
        colorBoard.add(true);
      } else {
        totalIncorrect += 1;
        colorBoard.add(false);
      }
    }
    return colorBoard;
  }

  bool isFinished() => stars == 10;

  void reset() {
    stars = 0;
    trys = 0;
    correct = 0;
    _question = 0;
  }
}

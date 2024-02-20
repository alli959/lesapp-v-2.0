import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class QuizBrainLvlOneVoice {
  // Audio audio = Audio();
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String question = "";
  int whichSound = 0;
  int stars = 0;
  double finalscore = 0.0;
  final AudioCache cache = AudioCache();
  final String correctSound = 'sound/correct_sound.mp3';
  final String incorrectSound = 'sound/incorrect_sound.mp3';
  final AudioPlayer correctPlayer = AudioPlayer();
  final AudioPlayer incorrectPlayer = AudioPlayer();

  final PrefVoice prefVoice = PrefVoice.DORA;

  List<String> _questionBank = [
    'Aa',
    'Áá',
    'Bb',
    'Cc',
    'Dd',
    'Ee',
    'Éé',
    'Ff',
    'Gg',
    'Hh',
    'Ii',
    'Íí',
    'Jj',
    'Kk',
    'Ll',
    'Mm',
    'Nn',
    'Oo',
    'Óó',
    'Pp',
    'Qq',
    'Rr',
    'Ss',
    'Tt',
    'Vv',
    'Xx',
    'Yy',
    'Ýý',
    'Zz',
    'Þþ',
    'Ææ',
    'Öö'
  ];

  String getQuestionText() {
    _question = Random().nextInt(_questionBank.length - 1);
    question = _questionBank[_question];
    return question;
  }

  String bestLastWord(
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

    return closestIndex == -1 ? lWords : alt[closestIndex].transcript;
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
    Map<String, int> mapQuestion = {};
    Map<String, int> mapAnswer = {};
    List<bool> questionMap = [];
    List<bool> answerMap = [];
    // Creating hashmap of questions
    for (var i = 0; i < questionArr.length; i++) {
      var key = questionArr[i].toLowerCase();
      mapQuestion[key] = (mapQuestion[key] ?? 0) + 1;
    }

    // Creating hashmap of answers
    for (var i = 0; i < answerArr.length; i++) {
      var key = answerArr[i].toLowerCase();
      mapAnswer[key] = (mapAnswer[key] ?? 0) + 1;
    }

    // Creating colorBoard for questions
    /* TODO  IF A WORD IS DUPLICATE */
    for (var i = 0; i < questionArr.length; i++) {
      if (mapAnswer.containsKey(questionArr[i].toLowerCase())) {
        questionMap.add(true);
      } else {
        questionMap.add(false);
      }
    }

    // Creating colorBoard for answers
    /* TODO  IF A WORD IS DUPLICATE */

    for (var i = 0; i < answerArr.length; i++) {
      if (mapQuestion.containsKey(answerArr[i].toLowerCase())) {
        totalCorrect += 1;
        answerMap.add(true);
      } else {
        totalIncorrect += 1;
        answerMap.add(false);
      }
    }

    // calculating points
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

  bool isFinished() => stars == 10;

  void reset() {
    stars = 0;
    trys = 0;
    correct = 0;
    _question = 0;
  }
}

enum PrefVoice { DORA }

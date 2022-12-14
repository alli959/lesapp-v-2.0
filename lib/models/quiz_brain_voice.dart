import 'package:Lesaforrit/services/audio_session.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';

import './question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

import 'PrefVoice.dart';

class QuizBrainVoice {
  // Audio audio = Audio();
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String question;
  int whichSound;
  int stars = 0;
  double finalscore;
  AudioCache cache = AudioCache();
  String correctSound = 'assets/sound/correct_sound.mp3';
  String incorrectSound = 'sound/incorrect_sound.mp3';
  AudioPlayer correctPlayer = AudioPlayer();
  AudioPlayer incorrectPlayer = AudioPlayer();
  bool isCap;
  String typeofgame;
  String typeofgamedifficulty;
  bool hasInitialized = false;
  AudioSessionService audioSessionService;
  List<Question> _questionBank = [];

  QuizBrain({String typeofgame, String typeofdifficulty, bool isCap = true}) {
    this.typeofgame = typeofgame;
    this.typeofgamedifficulty = typeofdifficulty;
    this.isCap = isCap;
  }

  //add new values
  var prefVoice = PrefVoice.DORA;

  Future<AudioPlayer> playCorrect() async {
    try {
      await audioSessionService.setPlayerLocalUrl(correctSound, 70);
      await Future.delayed(Duration(milliseconds: 1000));
      audioSessionService.play();
      // correctPlayer = await cache.play(correctSound, volume: 0.2);
      // correctPlayer.stop();
    } catch (err) {
      print("there was an error playing correct sound $err");
      return null;
    }
    return null;
  }

  Future<AudioPlayer> playIncorrect() async {
    Question question = _questionBank[_question];
    String file = question.file;
    String file2 = question.file2;
    prefVoice = question.prefVoice;

    if (hasInitialized) {
      if (prefVoice == PrefVoice.DORA) {
        try {
          await audioSessionService.setPlayerUrl(file);
          audioSessionService.play();
          return null;
        } catch (err) {
          print("there was an error playing sound ${file}");
          return null;
        }
      } else {
        try {
          await audioSessionService.setPlayerUrl(file2);
          audioSessionService.play();
          return null;
        } catch (err) {
          print("there was an error playing sound ${file}");
          return null;
        }
      }
      // }
      // try {
      //   File file1 = await DefaultCacheManager().getSingleFile(sound1);
      //   print("file is $file1");
      //   Uint8List bytes = file1.readAsBytesSync();
      //   print("length if bytes is ${bytes.length}");
      //   print("bytes is $bytes");

      //   await spilari.playBytes(bytes);
      // } catch (err) {
      //   print("there was an error playing sound $err");
      //   return null;
      // }
    }
    return null;
  }

  void addData(List<Question> questionbank, String typeofgame,
      String difficulty, AudioSessionService _audioSessionServiceParam) {
    this.audioSessionService = _audioSessionServiceParam;
    print(
        "IN VOICE ADD DATA WITH (${questionbank.map((e) => e.questionText)})");

    if (typeofgame != null) {
      this.typeofgame = typeofgame;
    }
    if (difficulty != null) {
      this.typeofgamedifficulty = typeofgamedifficulty;
    }

    if (this.typeofgame == "letters") {
      if (!hasInitialized) {
        for (var i = 0; i < questionbank.length; i++) {
          Question question = questionbank[i];

          String text = question.questionText;
          if (text.toUpperCase() == text) {
            text = text + text.toLowerCase();
            print("text is $text");
            questionbank[i].questionText = text;
          } else {
            text = text.toUpperCase() + text;
            print("text is $text");
          }
          question.setQuestionText(text);
          this._questionBank.add(question);
        }
        hasInitialized = true;
      }
    } else {
      this._questionBank = questionbank;
      hasInitialized = true;
    }
  }

/*
Question Question(
  String questionText,
  bool questionAnswer,
  String file, [
  String file2,
  PrefVoice prefVoice,
])
*/
  String getQuestionText() {
    _question = Random().nextInt(_questionBank.length - 1);
    question = _questionBank[_question].questionText;
    return question;
  }

  dynamic bestLastWord(
      String lWords, String quest, List<SpeechRecognitionAlternative> alt) {
    int closestVal = lWords
        .toLowerCase()
        .compareTo(quest.toLowerCase()); //compare correct answer to voice input

    int closestIndex =
        -1; //index of closest value, if -1 then result.recongizedwords
    //check if alternates are closer to correct answer
    for (int i = 0; i < alt.length; i++) {
      String tempString = alt[i].transcript.trim();
      int temp = tempString.toLowerCase().compareTo(quest.toLowerCase());
      if (temp.abs() < closestVal.abs()) {
        print("temp < closestVal");
        print("tempString: $tempString");
        print("lastWords: $lWords");
        print("tempInt: $temp");
        print("closestValInt: $closestVal");

        closestIndex = i;
        closestVal = temp;
      }
    }

    if (closestIndex == -1) {
      return lWords;
    } else {
      print("there was another");
      print(alt[closestIndex].transcript);

      lWords = alt[closestIndex].transcript;

      return lWords;
    }
  }

  Map<String, Object> isCorrect(
      String userVoiceAnswer, String question, String lvl) {
    // if (quizBrain.isFinished() == true) {
    //   quizBrain.reset();
    // } else {
    if (lvl == "level_1") {
      if (question[0].substring(0, 1).toLowerCase() ==
          userVoiceAnswer[0].substring(0, 1).toLowerCase()) {
        userVoiceAnswer = question;
      }
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
      if (mapQuestion.containsKey(questionArr[i].toLowerCase())) {
        mapQuestion[questionArr[i].toLowerCase()] += 1;
      } else {
        mapQuestion[questionArr[i].toLowerCase()] = 1;
      }
    }

    // Creating hashmap of answers
    for (var i = 0; i < answerArr.length; i++) {
      if (mapAnswer.containsKey(answerArr[i].toLowerCase())) {
        mapAnswer[answerArr[i].toLowerCase()] += 1;
      } else {
        mapAnswer[answerArr[i].toLowerCase()] = 1;
      }
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
    // if (userVoiceAnswer.toLowerCase() == question.toLowerCase()) {
    //   return true;
    //   // }
    // }
    // return false;
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
    _question = 0; // kannski sleppa?
  }
}

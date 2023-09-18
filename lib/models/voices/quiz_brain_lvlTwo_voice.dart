import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class QuizBrainLvlTwoVoice {
  int _question = 0;
  int correct = 0;
  int trys = 0;
  late String question;
  late int whichSound;
  int stars = 0;
  late double finalscore;
  final AudioCache cache = AudioCache();
  final String correctSound = 'sound/correct_sound.mp3';
  final String incorrectSound = 'sound/incorrect_sound.mp3';
  final AudioPlayer correctPlayer = AudioPlayer();
  final AudioPlayer incorrectPlayer = AudioPlayer();

  Future<AudioPlayer> playCorrect() async {
    print("correct sound");
    return correctPlayer;
  }

  Future<AudioPlayer> playIncorrect() async {
    print("incorrect sound");
    return incorrectPlayer;
  }

  List<String> _questionBank = [
    'Að',
    'Api',
    'Ás',
    'Bæ',
    'Bú',
    'Bý',
    'Ég',
    'Ef',
    'Er',
    'Eru',
    'Fá',
    'Föt',
    'Gos',
    'Hér',
    'Kex',
    'Kú',
    'Mér',
    'Mig',
    'Nál',
    'Nú',
    'Ný',
    'Og',
    'Ör',
    'Rúm',
    'Sé',
    'Sem',
    'Sér',
    'Sig',
    'Sól',
    'Tá',
    'Tár',
    'Tær',
    'Þær',
    'Þau',
    'Þér',
    'Þú',
    'Því',
    'Til',
    'Tók',
    'Tré',
    'Upp',
    'Úr',
    'Út',
    'Var',
    'Vél',
    'Hús',
    'Rúm',
    'Hæ',
    'Ás',
    'Bál',
    'Dag',
    'Egg',
    'Eru',
    'Gær',
    'Gæs',
    'Ís',
    'Jól',
    'Kíví',
    'Kom',
    'Kýr',
    'Lax',
    'Má',
    'Mál',
    'Mús',
    'Róló',
    'Rót',
    'Sá',
    'Sem',
    'Sísí',
    'Te',
    'Þar',
    'Var',
    'Epli',
    'Gras',
    'Lamb',
    'Hús',
    'Ljós',
    'Kisa',
    'Bolli',
    'Kerti',
    'Stelpa',
    'Hjól',
    'Eðla',
    'Fluga',
    'Bíll',
    'Tölva',
    'Blár',
    'Djús',
    'Nammi',
    'Grís',
    'Glas',
    'Kaffi',
    'Fjall',
    'Snjór',
    'Húfa',
    'Augu',
    'Blóm',
    'Dreki',
    'Ungi',
    'Aftur',
    'Aldrei',
    'Allt',
    'Alltaf',
    'Baka',
    'Heim',
    'Hennar',
    'Henni',
    'Kjóll',
    'Ljón',
    'Meira',
    'Mikið',
    'Ostur',
    'Safi',
    'Saman',
    'Sími',
    'Hennar',
    'Sínum',
    'Skór',
    'Hvað',
    'Hana',
    'Varð',
    'Líka',
    'Bara',
    'Bátur',
    'Baun',
    'Fara',
    'Gæti',
    'Geit',
    'Gera',
    'Geta',
    'Grafa',
    'Gulur',
    'Hafi',
    'Hani',
    'Hans',
    'Hola',
    'Land',
    'Lauf',
    'Líka',
    'Lita',
    'Rófa',
    'Sama',
    'Síða',
    'Sjór',
    'Skip',
    'Skora',
    'Sófi',
    'Ugla',
    'Úlfur',
    'Vika',
    'Vinur',
    'Voffi',
  ];

  String getQuestionText() {
    _question = Random().nextInt(_questionBank.length - 1);
    question = _questionBank[_question];
    return question;
  }

  String bestLastWord(
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
    if (lvl == "level_1") {
      question = question.trim();
      userVoiceAnswer = userVoiceAnswer.trim();
      var questionLetter = question.substring(0, 1).toLowerCase();
      var answerLetter = userVoiceAnswer.substring(0, 1).toLowerCase();
      print("questionLetter = $questionLetter");
      print("answerLetter = $answerLetter");

      if (question.substring(0, 1).toLowerCase() ==
          userVoiceAnswer.substring(0, 1).toLowerCase()) {
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
      var key = questionArr[i].toLowerCase();
      mapQuestion[key] = (mapQuestion[key] ?? 0) + 1;
    }

    // Creating hashmap of answers
    for (var i = 0; i < questionArr.length; i++) {
      var key = questionArr[i].toLowerCase();
      mapQuestion[key] = (mapQuestion[key] ?? 0) + 1;
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
    return stars == 10;
  }

  void reset() {
    stars = 0;
    trys = 0;
    correct = 0;
    _question = 0;
  }
}

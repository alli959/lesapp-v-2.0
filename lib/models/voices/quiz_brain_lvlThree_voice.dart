import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';

import '../question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';

class QuizBrainLvlThreeVoice {
  // Audio audio = Audio();
  int _question = 0;
  int correct = 0;
  int trys = 0;
  String question;
  int whichSound;
  int stars = 0;
  double finalscore;
  AudioCache cache = AudioCache();
  String correctSound = 'sound/correct_sound.mp3';
  String incorrectSound = 'sound/incorrect_sound.mp3';
  AudioPlayer correctPlayer = AudioPlayer();
  AudioPlayer incorrectPlayer = AudioPlayer();

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

  List<String> _questionBank = [
    'Óli fór út að hjóla',
    'Eva hoppar í polla',
    'Gult og grænt blóm',
    'Mamma fór í búðina',
    'Gunni hjólaði heim',
    'Siggi er í símanum',
    'Krakkarnir eru að leika',
    'Kisan vill fá að drekka',
    'Hundurinn gelti á kisuna',
    'Strákarnir fóru í sund',
    'Ég fékk hjól í afmælisgjöf',
    'Arna borðaði bananann',
    'Benni kann að lesa',
    'Alda er í fimleikum',
    'Villi ætlar að fara í sund',
    'Amma segir Berglindi sögu',
    'Afi og Egill fóru á hestbak',
    'Þorgeir er úti í fótbolta',
    'Ara langar í tölvu',
    'Gummi horfir á sjónvarpið',
    'Afi og Óli fóru í göngutúr',
    'Villi horfir á barnatímann',
    'Lalli fór út að hlaupa',
    'Gummi fór út að leika',
    'Elín og Alda fóru í sund',
    'Mamma og pabbi löbbuðu í búðina',
    'Kisan kom ekki heim í gær',
    'Lúlli er alltaf að veiða fiska',
    'Villi kann alla stafina',
    'Tunglið er alveg fullt',
    'Elín fékk fullt af pökkum',
    'Toggi er alltaf úti að leika',
    'Þessi bíll er mjög gamall',
    'Bóndinn á traktor og gröfu',
    'Harpa vill alltaf vera í marki',
    'Egill er duglegur að púsla',
    'Eva spilar á píanó',
    'Jóna er í ballett',
    'Afi fór í sund',
    'Mamma gaf Óla ís',
    'Anna veiddi lax',
    'Öndin borðar brauð',
    'Ari fær líka ís',
    'Gunni fór út á róló',
    'Pabbi kann að baka',
    'Voffi gelti á kisu',
    'Ég var ekki heima',
    'Lítil græn eðla',
    'Ási hjólar hratt',
    'Arna hljóp heim',
    'Núna er rigning',
    'Mikki drekkur kók',
    'Klukkan er ellefu',
    'Magga klappar kisu',
    'Pabbi þvær þvottinn',
    'Hundar gelta',
    'Fuglar syngja',
    'Kisur mjálma',
    'Fiskurinn syndir',
    'Bleikt blóm',
    'Stór fluga',
    'Hátt fjall',
    'Amma syngur',
    'Palli hjólar',
    'Pabbi skrifar',
    'Stórir stafir',
    'Lítið ljón',
    'Mikki mús',
    'Stórt tré',
    'Harpa les',
    'Alda hlær',
    'Hestar hneggja',
    'Hann hljóp út',
    'Henni er kalt',
    'Hann er uppi',
    'Hún átti hjól',
    'Lambið borðar gras',
    'Siggi fékk kex',
    'Ávextir eru hollir',
    'Fiðrildið er fallegt',
    'Eva borðar pulsur',
    'Ég á síma',
    'Mamma les bók',
    'Óli spilar á flautu',
    'Traktorinn er horfinn',
    'Rútan er komin',
    'Nú er dimmt',
    'Ása les heima',
    'Máni fór út',
    'Hún fór upp',
    'Blómið er gult',
    'Magga sá mús',
    'Gæsin borðar gras',
    'Músin var inni',
    'Eva og Ási spila',
  ];

  String getQuestionText() {
    _question = Random().nextInt(_questionBank.length - 1);
    question = _questionBank[_question];
    return question;
  }

  Map<String, Object> isCorrect(
      String userVoiceAnswer, String question, String lvl) {
    // if (quizBrain.isFinished() == true) {
    //   quizBrain.reset();
    // } else {

    print("question = $question");
    print("answer = $userVoiceAnswer");
    if (lvl == "level_1") {
      if (question[0].toLowerCase() == userVoiceAnswer[0].toLowerCase()) {
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

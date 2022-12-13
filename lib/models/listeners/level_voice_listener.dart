import 'dart:core';

import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'level_finish_listener.dart';

enum VoiceGameType { letters, words, sentences }

abstract class LevelVoiceListener {
  VoiceGameType type;
  String level;
  String typeofgame;
  List<String> typeofdifficulty;
  String selecteddifficulty;
  bool haschosendifficulty;
  Map<String, String> difftranslate;
  String title;
  int questionTime;
  Widget finishWidget;
  Color contColor;
  Color cardColor;
  Color stigColor;
  bool isLetter;
  BuildContext context;
  FinishGameType finishtype;

  factory LevelVoiceListener(VoiceGameType type, [BuildContext context]) {
    switch (type) {
      case VoiceGameType.letters:
        type = VoiceGameType.letters;
        return LettersConfig();
      case VoiceGameType.words:
        type = VoiceGameType.words;
        return WordsConfig();
      case VoiceGameType.sentences:
        type = VoiceGameType.sentences;
        return SentencesConfig();
      default:
        type = VoiceGameType.sentences;
        return SentencesConfig();
    }
  }

  void init();

  void setDifficulty(String diff) {
    this.selecteddifficulty = diff;
    this.title = this.difftranslate[diff];
  }
}

class LettersConfig implements LevelVoiceListener {
  @override
  Color cardColor;

  @override
  Color contColor;

  @override
  Map<String, String> difftranslate;

  @override
  Widget finishWidget;

  @override
  bool isLetter;

  @override
  String level;

  @override
  int questionTime;

  @override
  String selecteddifficulty;

  @override
  Color stigColor;

  @override
  String title;

  @override
  VoiceGameType type;

  @override
  String typeofgame;

  @override
  List<String> typeofdifficulty;

  @override
  bool haschosendifficulty;

  @override
  BuildContext context;

  @override
  FinishGameType finishtype;

  @override
  void init() {
    this.level = "level_1";
    this.typeofgame = "letters";
    this.typeofdifficulty = [];
    this.selecteddifficulty = "low";
    this.haschosendifficulty = true;
    this.difftranslate = {};
    this.title = "Raddgreining Stafa";
    this.questionTime = 3;
    this.contColor = lightCyan;
    this.cardColor = Color(0xFF81FFE9);
    this.stigColor = lightCyan;
    this.isLetter = true;
    this.finishtype = FinishGameType.voiceLetters;
  }

  @override
  void setDifficulty(String diff) {
    // TODO: implement setDifficulty
  }
}

class WordsConfig implements LevelVoiceListener {
  @override
  Color cardColor;

  @override
  Color contColor;

  @override
  Map<String, String> difftranslate;

  @override
  Widget finishWidget;

  @override
  bool isLetter;

  @override
  String level;

  @override
  int questionTime;

  @override
  String selecteddifficulty;

  @override
  Color stigColor;

  @override
  String title;

  @override
  VoiceGameType type;

  @override
  String typeofgame;

  @override
  List<String> typeofdifficulty;

  @override
  bool haschosendifficulty;

  @override
  BuildContext context;

  @override
  FinishGameType finishtype;

  @override
  void init() {
    this.level = "level_2";
    this.typeofgame = "words";
    this.typeofdifficulty = ["easy,medium"];
    this.selecteddifficulty = "easy";
    this.haschosendifficulty = false;
    this.difftranslate = {"easy": "Auðvellt", "medium": "Miðlungs"};
    this.title = "Raddgreining Orða ${difftranslate[selecteddifficulty]}";
    this.questionTime = 5;
    this.contColor = Color.fromARGB(255, 109, 223, 112);
    this.cardColor = cardColorLvlTwo;
    this.stigColor = lightGreen;
    this.isLetter = false;
  }

  @override
  void setDifficulty(String diff) {
    this.selecteddifficulty = diff;
    this.finishtype = diff == "easy"
        ? FinishGameType.voiceWordsEasy
        : FinishGameType.voiceWordsMedium;
    this.haschosendifficulty = true;
    this.title = "Raddgreining Orða ${difftranslate[selecteddifficulty]}";
  }
}

class SentencesConfig implements LevelVoiceListener {
  @override
  Color cardColor;

  @override
  Color contColor;

  @override
  Map<String, String> difftranslate;

  @override
  Widget finishWidget;

  @override
  bool isLetter;

  @override
  String level;

  @override
  int questionTime;

  @override
  String selecteddifficulty;

  @override
  Color stigColor;

  @override
  String title;

  @override
  VoiceGameType type;

  @override
  String typeofgame;

  @override
  List<String> typeofdifficulty;

  @override
  bool haschosendifficulty;

  @override
  BuildContext context;

  @override
  FinishGameType finishtype;

  @override
  void init() {
    print("INIT CALLED !!!!");
    this.level = "level_3";
    this.typeofgame = "sentences";
    this.typeofdifficulty = ["easy,medium"];
    this.selecteddifficulty = "easy";
    this.haschosendifficulty = false;
    this.difftranslate = {"easy": "Auðvellt", "medium": "Miðlungs"};
    this.title = "Raddgreining Setninga ${difftranslate[selecteddifficulty]}";
    this.questionTime = 8;
    this.contColor = lightBlue;
    this.cardColor = cardColorLvlThree;
    this.stigColor = lightBlue;
    this.isLetter = false;
  }

  @override
  void setDifficulty(String diff) {
    this.selecteddifficulty = diff;
    this.finishtype = diff == "easy"
        ? FinishGameType.voiceSentencesEasy
        : FinishGameType.voiceSentencesMedium;
    this.haschosendifficulty = true;
    this.title = "Raddgreining Setninga ${difftranslate[selecteddifficulty]}";
  }
}

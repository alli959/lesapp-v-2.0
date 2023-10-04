import 'dart:core';

import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'level_finish_listener.dart';

enum VoiceGameType { letters, words, sentences }

/// Represents the configuration for a voice game level.
abstract class LevelVoiceListener {
  late final VoiceGameType type;
  late final String level;
  late final String typeofgame;
  late final List<String> typeofdifficulty;
  late String selecteddifficulty;
  late bool haschosendifficulty;
  late final Map<String, String> difftranslate;
  late String title;
  late final int questionTime;
  late final Widget finishWidget;
  late final Color contColor;
  late final Color cardColor;
  late final Color stigColor;
  late final bool isLetter;
  late final BuildContext context;
  late final FinishGameType finishtype;

  LevelVoiceListener({required this.type});

  void init() {}

  void setDifficulty(String diff);
}

/// Configuration for the "letters" voice game type.
class LettersConfig extends LevelVoiceListener {
  LettersConfig() : super(type: VoiceGameType.letters);

  @override
  final Color cardColor = Color(0xFF81FFE9);

  @override
  void init() {
    level = "level_1";
    typeofgame = "letters";
    typeofdifficulty = [];
    selecteddifficulty = "low";
    haschosendifficulty = true;
    difftranslate = {};
    title = "Raddgreining Stafa";
    questionTime = 3;
    contColor = lightCyan;
    cardColor = Color(0xFF81FFE9);
    stigColor = lightCyan;
    isLetter = true;
    finishtype = FinishGameType.voiceLetters;
  }

  @override
  void setDifficulty(String diff) {
    selecteddifficulty = diff;
    finishtype = FinishGameType.voiceLetters;
    haschosendifficulty = true;
    title = "Raddgreining Stafa";
  }
}

/// Configuration for the "words" voice game type.
class WordsConfig extends LevelVoiceListener {
  WordsConfig() : super(type: VoiceGameType.words);

  @override
  final Color cardColor = cardColorLvlTwo;

  @override
  void init() {
    level = "level_2";
    typeofgame = "words";
    typeofdifficulty = ["easy", "medium"];
    selecteddifficulty = "easy";
    haschosendifficulty = false;
    difftranslate = {"easy": "Auðvellt", "medium": "Miðlungs"};
    title = "Raddgreining Orða ${difftranslate[selecteddifficulty]}";
    questionTime = 5;
    contColor = Color.fromARGB(255, 109, 223, 112);
    cardColor = cardColorLvlTwo;
    stigColor = lightGreen;
    isLetter = false;
  }

  @override
  void setDifficulty(String diff) {
    selecteddifficulty = diff;
    finishtype = diff == "easy"
        ? FinishGameType.voiceWordsEasy
        : FinishGameType.voiceWordsMedium;
    haschosendifficulty = true;
    title = "Raddgreining Orða ${difftranslate[selecteddifficulty]}";
  }
}

/// Configuration for the "sentences" voice game type.
class SentencesConfig extends LevelVoiceListener {
  SentencesConfig() : super(type: VoiceGameType.sentences);

  @override
  final Color cardColor = cardColorLvlThree;

  @override
  void init() {
    level = "level_3";
    typeofgame = "sentences";
    typeofdifficulty = ["easy", "medium"];
    selecteddifficulty = "easy";
    haschosendifficulty = false;
    difftranslate = {"easy": "Auðvellt", "medium": "Miðlungs"};
    title = "Raddgreining Setninga ${difftranslate[selecteddifficulty]}";
    questionTime = 8;
    contColor = lightBlue;
    cardColor = cardColorLvlThree;
    stigColor = lightBlue;
    isLetter = false;
  }

  @override
  void setDifficulty(String diff) {
    selecteddifficulty = diff;
    finishtype = diff == "easy"
        ? FinishGameType.voiceSentencesEasy
        : FinishGameType.voiceSentencesMedium;
    haschosendifficulty = true;
    title = "Raddgreining Setninga ${difftranslate[selecteddifficulty]}";
  }
}

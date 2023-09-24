import 'dart:core';

import 'package:Lesaforrit/models/listeners/level_finish_listener.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum GameType {
  letters,
  lettersCaps,
  wordsEasy,
  wordsMedium,
  sentencesEasy,
  sentencesMedium,
}

/// Represents the configuration for a game level.
abstract class LevelListener {
  late final GameType type;
  late final String typeofgame;
  late final String selecteddifficulty;
  late final String title;
  late final Color cardcolor;
  late final Color stigcolor;
  late final int shadowlevel;
  late final String bottombarimage;
  late final double fontsize;
  late final BuildContext context;
  late final bool isCap;
  late final FinishGameType finishtype;

  LevelListener({required this.type});

  void init();
}

/// Configuration for the "letters" and "lettersCaps" game types.
class LettersConfig extends LevelListener {
  LettersConfig({
    required GameType type,
    required String selecteddifficulty,
    required bool isCap,
    required FinishGameType finishtype,
  }) : super(type: type) {
    this.selecteddifficulty = selecteddifficulty;
    this.isCap = isCap;
    this.finishtype = finishtype;
  }

  @override
  void init() {
    typeofgame = "letters";
    title = "${isCap ? "Lág" : "Há"}stafir";
    cardcolor = cardColor;
    stigcolor = lightCyan;
    shadowlevel = 145;
    bottombarimage = "assets/images/bottomBar_ye.png";
    fontsize = 100;
  }
}

/// Configuration for the "wordsEasy" and "wordsMedium" game types.
class WordsConfig extends LevelListener {
  WordsConfig({
    required GameType type,
    required String selecteddifficulty,
    required FinishGameType finishtype,
  }) : super(type: type) {
    this.selecteddifficulty = selecteddifficulty;
    this.finishtype = finishtype;
  }

  @override
  void init() {
    typeofgame = "words";
    title = "${selecteddifficulty == "easy" ? "Styttri" : "Lengri"} orð";
    cardcolor = cardColorLvlTwo;
    stigcolor = lightGreen;
    shadowlevel = 145;
    bottombarimage = "assets/images/bottomBar_gr.png";
    fontsize = 39;
  }
}

/// Configuration for the "sentencesEasy" and "sentencesMedium" game types.
class SentencesConfig extends LevelListener {
  SentencesConfig({
    required GameType type,
    required String selecteddifficulty,
    required FinishGameType finishtype,
  }) : super(type: type) {
    this.selecteddifficulty = selecteddifficulty;
    this.finishtype = finishtype;
  }

  @override
  void init() {
    typeofgame = "sentences";
    title = "${selecteddifficulty == "easy" ? "Styttri" : "Lengri"} setning";
    cardcolor = cardColorLvlThree;
    stigcolor = lightBlue;
    shadowlevel = 30;
    bottombarimage = 'assets/images/bottomBar_bl.png';
    fontsize = 39;
  }
}

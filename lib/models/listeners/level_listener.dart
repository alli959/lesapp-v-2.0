import 'dart:core';

import 'package:Lesaforrit/models/listeners/level_finish_listener.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum GameType {
  letters,
  lettersCaps,
  wordsEasy,
  wordsMedium,
  sentencesEasy,
  sentencesMedium,
}

abstract class LevelListener {
  GameType type;
  String typeofgame;
  String selecteddifficulty;
  String title;
  Color cardcolor;
  Color stigcolor;
  int shadowlevel;
  String bottombarimage;
  double fontsize;
  BuildContext context;
  bool isCap = false;
  FinishGameType finishtype;

  factory LevelListener(GameType type, [BuildContext context]) {
    switch (type) {
      case GameType.letters:
        type = GameType.letters;
        return LettersConfig(
            selecteddifficulty: "low",
            isCap: false,
            finishtype: FinishGameType.letters);
      case GameType.lettersCaps:
        type = GameType.lettersCaps;
        return LettersConfig(
            selecteddifficulty: "caps",
            isCap: true,
            finishtype: FinishGameType.lettersCaps);
      case GameType.wordsEasy:
        type = GameType.wordsEasy;
        return WordsConfig(
            selecteddifficulty: "easy", finishtype: FinishGameType.wordsEasy);
      case GameType.wordsMedium:
        type = GameType.wordsMedium;
        return WordsConfig(
            selecteddifficulty: "medium",
            finishtype: FinishGameType.wordsMedium);
      case GameType.sentencesEasy:
        type = GameType.sentencesEasy;
        return SentencesConfig(
            selecteddifficulty: "easy",
            finishtype: FinishGameType.sentencesEasy);
      case GameType.sentencesMedium:
        type = GameType.sentencesMedium;
        return SentencesConfig(
            selecteddifficulty: "medium",
            finishtype: FinishGameType.sentencesMedium);
      default:
        return SentencesConfig(
            selecteddifficulty: "easy",
            finishtype: FinishGameType.sentencesEasy);
    }
  }

  void init();
}

class LettersConfig implements LevelListener {
  LettersConfig(
      {String selecteddifficulty, bool isCap, FinishGameType finishtype}) {
    this.selecteddifficulty = selecteddifficulty;
    this.isCap = isCap;
    this.finishtype = finishtype;
  }
  @override
  Color cardcolor;

  @override
  Color stigcolor;

  @override
  String title;

  @override
  GameType type;

  @override
  String typeofgame;

  @override
  String selecteddifficulty;

  @override
  int shadowlevel;

  @override
  String bottombarimage;

  @override
  double fontsize;

  @override
  BuildContext context;

  @override
  bool isCap;

  @override
  FinishGameType finishtype;

  @override
  void init() {
    this.typeofgame = "letters";
    this.title = "${selecteddifficulty == "low" ? "Lág" : "Há"}stafir";
    this.cardcolor = cardColor;
    this.stigcolor = lightCyan;
    this.shadowlevel = 145;
    this.bottombarimage = "assets/images/bottomBar_ye.png";
    this.fontsize = 100;
  }
}

class WordsConfig implements LevelListener {
  WordsConfig({String selecteddifficulty, FinishGameType finishtype}) {
    this.selecteddifficulty = selecteddifficulty;
    this.finishtype = finishtype;
  }
  @override
  Color cardcolor;

  @override
  Color stigcolor;

  @override
  String title;

  @override
  GameType type;

  @override
  String typeofgame;

  @override
  String selecteddifficulty;

  @override
  int shadowlevel;

  @override
  String bottombarimage;

  @override
  double fontsize;

  @override
  BuildContext context;

  @override
  bool isCap;

  @override
  FinishGameType finishtype;

  @override
  void init() {
    this.typeofgame = "words";
    this.title = "${selecteddifficulty == "easy" ? "Styttri" : "Lengri"} orð";
    this.cardcolor = cardColorLvlTwo;
    this.stigcolor = lightGreen;
    this.shadowlevel = 145;
    this.bottombarimage = "assets/images/bottomBar_gr.png";
    this.fontsize = 39;
  }
}

class SentencesConfig implements LevelListener {
  SentencesConfig({String selecteddifficulty, FinishGameType finishtype}) {
    this.selecteddifficulty = selecteddifficulty;
    this.finishtype = finishtype;
  }
  @override
  Color cardcolor;

  @override
  Color stigcolor;

  @override
  String title;

  @override
  GameType type;

  @override
  String typeofgame;

  @override
  String selecteddifficulty;

  @override
  int shadowlevel;

  @override
  String bottombarimage;

  @override
  double fontsize;

  @override
  BuildContext context;

  @override
  bool isCap;

  @override
  FinishGameType finishtype;

  @override
  void init() {
    this.typeofgame = "sentences";
    this.title =
        "${selecteddifficulty == "easy" ? "Styttri" : "Lengri"} setning";
    this.cardcolor = cardColorLvlThree;
    this.stigcolor = lightBlue;
    this.shadowlevel = 30;
    this.bottombarimage = 'assets/images/bottomBar_bl.png';
    this.fontsize = 39;
  }
}

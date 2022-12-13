import 'dart:core';

import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum FinishGameType {
  letters,
  lettersCaps,
  voiceLetters,
  wordsEasy,
  wordsMedium,
  voiceWordsEasy,
  voiceWordsMedium,
  sentencesEasy,
  sentencesMedium,
  voiceSentencesEasy,
  voiceSentencesMedium,
}

abstract class FinishGameListener {
  FinishGameType gametype;
  String typeofkey;
  int stig;
  String image;
  Color cardcolor;
  String appBarText;
  factory FinishGameListener(FinishGameType type, [BuildContext context]) {
    switch (type) {
      case FinishGameType.letters:
        return LettersConfig();
      case FinishGameType.lettersCaps:
        return LettersCapsConfig();
      case FinishGameType.voiceLetters:
        return VoiceLettersConfig();
      case FinishGameType.wordsEasy:
        return WordsEasyConfig();
      case FinishGameType.wordsMedium:
        return WordsMediumConfig();
      case FinishGameType.voiceWordsEasy:
        return VoiceWordsEasyConfig();
      case FinishGameType.voiceWordsMedium:
        return VoiceWordsMediumConfig();
      case FinishGameType.sentencesEasy:
        return SentencesEasyConfig();
      case FinishGameType.sentencesMedium:
        return SentencesMediumConfig();
      case FinishGameType.voiceSentencesEasy:
        return VoiceSentencesEasyConfig();
      case FinishGameType.voiceSentencesMedium:
        return VoiceSentencesMediumConfig();
      default:
        return LettersConfig();
    }
  }

  void init();
}

class LettersConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Lágstafir';
    this.cardcolor = cardColor;
    this.gametype = FinishGameType.letters;
    this.image = 'assets/images/cat_skuggi-05.png';
    this.stig = 0;
    this.typeofkey = 'lvlOneScore';
  }
}

class LettersCapsConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Hástafir';
    this.cardcolor = cardColorCaps;
    this.gametype = FinishGameType.lettersCaps;
    this.image = 'assets/images/cat_skuggi-05.png';
    this.stig = 0;
    this.typeofkey = 'lvlOneCapsScore';
  }
}

class VoiceLettersConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Upplesnir stafir';
    this.cardcolor = cardColor;
    this.gametype = FinishGameType.voiceLetters;
    this.image = 'assets/images/cat_skuggi-05.png';
    this.stig = 0;
    this.typeofkey = 'lvlOneVoiceScore';
  }
}

class WordsEasyConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Stutt orð';
    this.cardcolor = cardColorLvlTwo;
    this.gametype = FinishGameType.wordsEasy;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoEasyScore';
  }
}

class WordsMediumConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Löng orð';
    this.cardcolor = cardColorLvlTwo;
    this.gametype = FinishGameType.wordsMedium;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoMediumScore';
  }
}

//* IMPORTANT: NEED TO ADD DIFFICULTY FOR READ OUT LOUD WORDS AND SENTENCES
class VoiceWordsEasyConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Upplesnir stutt orð';
    this.cardcolor = cardColorLvlTwo;
    this.gametype = FinishGameType.voiceWordsEasy;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoVoiceScore'; // TODO: CHANGE TO CORRECT KEY
  }
}

//* IMPORTANT: NEED TO ADD DIFFICULTY FOR READ OUT LOUD WORDS AND SENTENCES
class VoiceWordsMediumConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Upplesnir löng orð';
    this.cardcolor = cardColorLvlTwo;
    this.gametype = FinishGameType.voiceWordsMedium;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoVoiceScore'; // TODO: CHANGE TO CORRECT KEY
  }
}

class SentencesEasyConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Stuttar setningar';
    this.cardcolor = cardColorLvlThree;
    this.gametype = FinishGameType.sentencesEasy;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeEasyScore';
  }
}

class SentencesMediumConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Langar setningar';
    this.cardcolor = cardColorLvlThree;
    this.gametype = FinishGameType.sentencesMedium;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeMediumScore';
  }
}

//* IMPORTANT: NEED TO ADD DIFFICULTY FOR READ OUT LOUD WORDS AND SENTENCES
class VoiceSentencesEasyConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Upplesnar stuttar setningar';
    this.cardcolor = cardColorLvlThree;
    this.gametype = FinishGameType.voiceSentencesEasy;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeVoiceScore'; // TODO: CHANGE TO CORRECT KEY
  }
}

class VoiceSentencesMediumConfig implements FinishGameListener {
  @override
  String appBarText;

  @override
  Color cardcolor;

  @override
  FinishGameType gametype;

  @override
  String image;

  @override
  int stig;

  @override
  String typeofkey;

  @override
  void init() {
    this.appBarText = 'Upplesnar langar setningar';
    this.cardcolor = cardColorLvlThree;
    this.gametype = FinishGameType.voiceSentencesMedium;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeVoiceScore'; // TODO: CHANGE TO CORRECT KEY
  }
}

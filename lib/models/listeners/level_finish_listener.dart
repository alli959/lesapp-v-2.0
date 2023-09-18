import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';

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

/// An abstract class to represent the configuration for the end of a game.
abstract class FinishGameListener {
  final FinishGameType gametype;
  late final String appBarText;
  late final Color cardcolor;
  late final String image;
  late final int stig;
  late final String typeofkey;

  FinishGameListener(this.gametype);

  void init();

  factory FinishGameListener.of(FinishGameType type) {
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
}

/// Configuration for the "letters" game type.
class LettersConfig extends FinishGameListener {
  LettersConfig() : super(FinishGameType.letters);

  @override
  void init() {
    appBarText = 'Lágstafir';
    cardcolor = cardColor;
    image = 'assets/images/cat_skuggi-05.png';
    stig = 0;
    typeofkey = 'lvlOneScore';
  }
}

/// Configuration for the "lettersCaps" game type.
class LettersCapsConfig extends FinishGameListener {
  LettersCapsConfig() : super(FinishGameType.lettersCaps);

  @override
  void init() {
    appBarText = 'Hástafir';
    cardcolor = cardColorCaps;
    image = 'assets/images/cat_skuggi-05.png';
    stig = 0;
    typeofkey = 'lvlOneCapsScore';
  }
}

/// Configuration for the "voiceLetters" game type.
class VoiceLettersConfig extends FinishGameListener {
  VoiceLettersConfig() : super(FinishGameType.voiceLetters);

  @override
  void init() {
    appBarText = 'Upplesnir stafir';
    cardcolor = cardColor;
    image = 'assets/images/cat_skuggi-05.png';
    stig = 0;
    typeofkey = 'lvlOneVoiceScore';
  }
}

class WordsEasyConfig extends FinishGameListener {
  WordsEasyConfig() : super(FinishGameType.wordsEasy);

  @override
  void init() {
    appBarText = 'Stutt orð';
    cardcolor = cardColorLvlTwo;
    image = 'assets/images/fish_skuggi-04.png';
    stig = 0;
    typeofkey = 'lvlTwoEasyScore';
  }
}

class WordsMediumConfig extends FinishGameListener {
  WordsMediumConfig() : super(FinishGameType.wordsMedium);

  @override
  void init() {
    this.appBarText = 'Löng orð';
    this.cardcolor = cardColorLvlTwo;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoMediumScore';
  }
}

class VoiceWordsEasyConfig extends FinishGameListener {
  VoiceWordsEasyConfig() : super(FinishGameType.voiceWordsEasy);

  @override
  void init() {
    this.appBarText = 'Upplesnir stutt orð';
    this.cardcolor = cardColorLvlTwo;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoVoiceScore';
  }
}

class VoiceWordsMediumConfig extends FinishGameListener {
  VoiceWordsMediumConfig() : super(FinishGameType.voiceWordsMedium);
  @override
  void init() {
    this.appBarText = 'Upplesnir löng orð';
    this.cardcolor = cardColorLvlTwo;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoVoiceMediumScore';
  }
}

class SentencesEasyConfig extends FinishGameListener {
  SentencesEasyConfig() : super(FinishGameType.sentencesEasy);

  @override
  void init() {
    this.appBarText = 'Stuttar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeEasyScore';
  }
}

class SentencesMediumConfig extends FinishGameListener {
  SentencesMediumConfig() : super(FinishGameType.sentencesMedium);
  @override
  void init() {
    this.appBarText = 'Langar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeMediumScore';
  }
}

class VoiceSentencesEasyConfig extends FinishGameListener {
  VoiceSentencesEasyConfig() : super(FinishGameType.voiceSentencesEasy);
  @override
  void init() {
    this.appBarText = 'Upplesnar stuttar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeVoiceScore';
  }
}

class VoiceSentencesMediumConfig extends FinishGameListener {
  VoiceSentencesMediumConfig() : super(FinishGameType.voiceSentencesMedium);
  @override
  void init() {
    this.appBarText = 'Upplesnar langar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeVoiceMediumScore'; // TODO: CHANGE TO CORRECT KEY
  }
}

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
        return FinishLettersConfig();
      case FinishGameType.lettersCaps:
        return FinishLettersCapsConfig();
      case FinishGameType.voiceLetters:
        return FinishVoiceLettersConfig();
      case FinishGameType.wordsEasy:
        return FinishWordsEasyConfig();
      case FinishGameType.wordsMedium:
        return FinishWordsMediumConfig();
      case FinishGameType.voiceWordsEasy:
        return FinishVoiceWordsEasyConfig();
      case FinishGameType.voiceWordsMedium:
        return FinishVoiceWordsMediumConfig();
      case FinishGameType.sentencesEasy:
        return FinishSentencesEasyConfig();
      case FinishGameType.sentencesMedium:
        return FinishSentencesMediumConfig();
      case FinishGameType.voiceSentencesEasy:
        return FinishVoiceSentencesEasyConfig();
      case FinishGameType.voiceSentencesMedium:
        return FinishVoiceSentencesMediumConfig();
      default:
        return FinishLettersConfig();
    }
  }
}

/// Configuration for the "letters" game type.
class FinishLettersConfig extends FinishGameListener {
  FinishLettersConfig() : super(FinishGameType.letters);

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
class FinishLettersCapsConfig extends FinishGameListener {
  FinishLettersCapsConfig() : super(FinishGameType.lettersCaps);

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
class FinishVoiceLettersConfig extends FinishGameListener {
  FinishVoiceLettersConfig() : super(FinishGameType.voiceLetters);

  @override
  void init() {
    appBarText = 'Upplesnir stafir';
    cardcolor = cardColor;
    image = 'assets/images/cat_skuggi-05.png';
    stig = 0;
    typeofkey = 'lvlOneVoiceScore';
  }
}

class FinishWordsEasyConfig extends FinishGameListener {
  FinishWordsEasyConfig() : super(FinishGameType.wordsEasy);

  @override
  void init() {
    appBarText = 'Stutt orð';
    cardcolor = cardColorLvlTwo;
    image = 'assets/images/fish_skuggi-04.png';
    stig = 0;
    typeofkey = 'lvlTwoEasyScore';
  }
}

class FinishWordsMediumConfig extends FinishGameListener {
  FinishWordsMediumConfig() : super(FinishGameType.wordsMedium);

  @override
  void init() {
    this.appBarText = 'Löng orð';
    this.cardcolor = cardColorLvlTwo;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoMediumScore';
  }
}

class FinishVoiceWordsEasyConfig extends FinishGameListener {
  FinishVoiceWordsEasyConfig() : super(FinishGameType.voiceWordsEasy);

  @override
  void init() {
    this.appBarText = 'Upplesnir stutt orð';
    this.cardcolor = cardColorLvlTwo;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoVoiceScore';
  }
}

class FinishVoiceWordsMediumConfig extends FinishGameListener {
  FinishVoiceWordsMediumConfig() : super(FinishGameType.voiceWordsMedium);
  @override
  void init() {
    this.appBarText = 'Upplesnir löng orð';
    this.cardcolor = cardColorLvlTwo;
    this.image = 'assets/images/fish_skuggi-04.png';
    this.stig = 0;
    this.typeofkey = 'lvlTwoVoiceMediumScore';
  }
}

class FinishSentencesEasyConfig extends FinishGameListener {
  FinishSentencesEasyConfig() : super(FinishGameType.sentencesEasy);

  @override
  void init() {
    this.appBarText = 'Stuttar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeEasyScore';
  }
}

class FinishSentencesMediumConfig extends FinishGameListener {
  FinishSentencesMediumConfig() : super(FinishGameType.sentencesMedium);
  @override
  void init() {
    this.appBarText = 'Langar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeMediumScore';
  }
}

class FinishVoiceSentencesEasyConfig extends FinishGameListener {
  FinishVoiceSentencesEasyConfig() : super(FinishGameType.voiceSentencesEasy);
  @override
  void init() {
    this.appBarText = 'Upplesnar stuttar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeVoiceScore';
  }
}

class FinishVoiceSentencesMediumConfig extends FinishGameListener {
  FinishVoiceSentencesMediumConfig()
      : super(FinishGameType.voiceSentencesMedium);
  @override
  void init() {
    this.appBarText = 'Upplesnar langar setningar';
    this.cardcolor = cardColorLvlThree;
    this.image = 'assets/images/bear_shadow.png';
    this.stig = 0;
    this.typeofkey = 'lvlThreeVoiceMediumScore'; // TODO: CHANGE TO CORRECT KEY
  }
}

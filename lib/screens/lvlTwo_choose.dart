import 'package:Lesaforrit/models/choose_long_short.dart';
import 'package:Lesaforrit/models/listeners/level_listener.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import '../components/arguments.dart';
import '../models/listeners/level_voice_listener.dart';
import 'level.dart';
import 'level_voice.dart';

class LvlTwoChoose extends StatelessWidget {
  static const String id = 'lvl_two_choose';

  @override
  Widget build(BuildContext context) {
    return Choose(
        buttonOne: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Level.id, (Route<dynamic> route) => false,
              arguments: LevelArguments(GameType.wordsEasy));
          // Navigator.pushNamed(context, LevelTwoShort.id);  // þessi hreinsar ekki routes en efri gerir það
        },
        buttonTwo: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Level.id, (Route<dynamic> route) => false,
              arguments: LevelArguments(GameType.wordsMedium));
          // Navigator.pushNamed(context, LevelTwo.id);
        },
        buttonThree: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelVoice.id, (Route<dynamic> route) => false,
              arguments: LevelVoiceArguments(VoiceGameType.words));
        },
        buttonTextOne: 'Stutt orð',
        buttonTextTwo: 'Lengri orð',
        buttonTextThree: 'Talgreining',
        appBarColor: cardColorLvlTwo,
        appBarText: 'Orð',
        image: 'assets/images/level_buttons-2.png');
  }
}

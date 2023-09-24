import 'package:Lesaforrit/components/arguments.dart';
import 'package:Lesaforrit/models/choose_long_short.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import '../models/listeners/level_listener.dart';
import '../models/listeners/level_voice_listener.dart';
import 'level.dart';
import 'level_voice.dart';

class LvlOneChoose extends StatelessWidget {
  static const String id = 'lvl_one_choose';

  @override
  Widget build(BuildContext context) {
    return Choose(
        buttonOne: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Level.id, (Route<dynamic> route) => false,
              arguments: LevelArguments(
                GameType.lettersCaps,
                "easy",
                true,
              ));
          //Navigator.pushNamed(context, LevelOneCap.id);
        },
        buttonTwo: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Level.id, (Route<dynamic> route) => false,
              arguments: LevelArguments(
                GameType.letters,
                "easy",
                false,
              ));
          //Navigator.pushNamed(context, LevelOne.id);
        },
        buttonThree: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelVoice.id, (Route<dynamic> route) => false,
              arguments: LevelVoiceArguments(VoiceGameType.letters));
          //Navigator.pushNamed(context, LevelOne.id);
        },
        buttonTextOne: 'Hástafir',
        buttonTextTwo: 'Lágstafir',
        buttonTextThree: 'Talgreining',
        appBarColor: cardColor,
        appBarText: 'Stafir',
        image: 'assets/images/level_buttons-1.png');
  }
}

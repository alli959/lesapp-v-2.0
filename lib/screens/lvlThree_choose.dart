import 'package:Lesaforrit/models/choose_long_short.dart';
import 'package:Lesaforrit/models/listeners/level_voice_listener.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/game/audio_bloc.dart';
import '../components/arguments.dart';
import '../models/listeners/level_listener.dart';
import 'level.dart';
import 'level_voice.dart';

class LvlThreeChoose extends StatelessWidget {
  static const String id = 'lvl_three_choose';

  @override
  Widget build(BuildContext context) {
    return Choose(
        buttonOne: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Level.id, (Route<dynamic> route) => false,
              arguments: LevelArguments(GameType.sentencesEasy));
          // Navigator.pushNamed(context, LevelThreeShort.id);
        },
        buttonTwo: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Level.id, (Route<dynamic> route) => false,
              arguments: LevelArguments(GameType.sentencesMedium));
          // Navigator.pushNamed(context, LevelThree.id);
        },
        buttonThree: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelVoice.id, (Route<dynamic> route) => false,
              arguments: LevelVoiceArguments(VoiceGameType.sentences));
        },
        buttonTextOne: 'Stuttar setningar',
        buttonTextTwo: 'Lengri setningar',
        buttonTextThree: 'Talgreining',
        appBarText: 'Setningar',
        appBarColor: lightBlue,
        image: 'assets/images/level_buttons-3.png');
  }
}

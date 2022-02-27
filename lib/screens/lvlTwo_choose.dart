import 'package:Lesaforrit/models/choose_long_short.dart';
import 'package:Lesaforrit/screens/level_two_short.dart';
import 'package:Lesaforrit/screens/level_two_voice.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'level_two.dart';

class LvlTwoChoose extends StatelessWidget {
  static const String id = 'lvl_two_choose';

  @override
  Widget build(BuildContext context) {
    return Choose(
        buttonOne: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelTwoShort.id, (Route<dynamic> route) => false);
          // Navigator.pushNamed(context, LevelTwoShort.id);  // þessi hreinsar ekki routes en efri gerir það
        },
        buttonTwo: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelTwo.id, (Route<dynamic> route) => false);
          // Navigator.pushNamed(context, LevelTwo.id);
        },
        buttonThree: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelTwoVoice.id, (Route<dynamic> route) => false);
        },
        buttonTextOne: 'Stutt orð',
        buttonTextTwo: 'Lengri orð',
        buttonTextThree: 'Talgreining',
        appBarColor: cardColorLvlTwo,
        appBarText: 'Orð',
        image: 'assets/images/level_buttons-2.png');
  }
}

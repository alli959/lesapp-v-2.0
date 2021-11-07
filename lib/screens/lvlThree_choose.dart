import 'package:Lesaforrit/models/choose_long_short.dart';
import 'package:Lesaforrit/screens/level_three_voice.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'level_three.dart';
import 'level_three_short.dart';

class LvlThreeChoose extends StatelessWidget {
  static const String id = 'lvl_three_choose';

  @override
  Widget build(BuildContext context) {
    return Choose(
        buttonOne: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelThreeShort.id, (Route<dynamic> route) => false);
          // Navigator.pushNamed(context, LevelThreeShort.id);
        },
        buttonTwo: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelThree.id, (Route<dynamic> route) => false);
          // Navigator.pushNamed(context, LevelThree.id);
        },
        buttonThree: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelThreeVoice.id, (Route<dynamic> route) => false);
        },
        buttonTextOne: 'Stuttar setningar',
        buttonTextTwo: 'Lengri setningar',
        buttonTextThree: 'Talgreining',
        appBarText: 'Setningar',
        appBarColor: lightBlue,
        image: 'assets/images/level_buttons-3.png');
  }
}

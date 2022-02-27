import 'package:Lesaforrit/models/choose_long_short.dart';
import 'package:Lesaforrit/screens/level_one_voice.dart';
import 'package:Lesaforrit/screens/level_two_voice.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'level_one.dart';
import 'level_one_cap.dart';

class LvlOneChoose extends StatelessWidget {
  static const String id = 'lvl_one_choose';

  @override
  Widget build(BuildContext context) {
    return Choose(
        buttonOne: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelOneCap.id, (Route<dynamic> route) => false);
          //Navigator.pushNamed(context, LevelOneCap.id);
        },
        buttonTwo: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelOne.id, (Route<dynamic> route) => false);
          //Navigator.pushNamed(context, LevelOne.id);
        },
        buttonThree: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LevelOneVoice.id, (Route<dynamic> route) => false);
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

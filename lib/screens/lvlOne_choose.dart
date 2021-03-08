import 'package:Lesaforrit/models/choose_long_short.dart';
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
        buttonTextOne: 'Hástafir',
        buttonTextTwo: 'Lágstafir',
        appBarColor: cardColor,
        appBarText: 'Stafir',
        image: 'assets/images/level_buttons-1.png');
  }
}

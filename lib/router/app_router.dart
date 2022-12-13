import 'package:Lesaforrit/screens/level_voice.dart';
import 'package:flutter/material.dart';

import 'package:Lesaforrit/screens/authenticate/authenticate.dart';
import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:Lesaforrit/screens/home/read_tile.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/screens/home/user_list.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/my_profile.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/screens/wrapper.dart';

import '../components/arguments.dart';
import '../screens/level.dart';
import '../screens/level_finish.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    print("settings name is => ${settings.name}");
    switch (settings.name) {
      case 'level_voice':
        var args = settings.arguments as LevelVoiceArguments;
        print("at level_voice place");
        return MaterialPageRoute(
          builder: (_) => LevelVoice(args),
        );
      case 'level':
        var args = settings.arguments as LevelArguments;
        print("at level_voice place");
        return MaterialPageRoute(
          builder: (_) => Level(args),
        );
      case 'LevelFinish':
        var args = settings.arguments as LevelFinishArguments;
        print("at level_finish place");
        return MaterialPageRoute(
          builder: (_) => LevelFinish(args),
        );
    }
  }
}

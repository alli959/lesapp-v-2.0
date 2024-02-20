import 'package:Lesaforrit/screens/level_voice.dart';
import 'package:flutter/material.dart';

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
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';

import 'package:Lesaforrit/screens/authenticate/authenticate.dart';
import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:Lesaforrit/screens/home/read_tile.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/screens/home/user_list.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/level_one.dart';
import 'package:Lesaforrit/screens/level_one_cap.dart';
import 'package:Lesaforrit/screens/level_one_caps_finish.dart';
import 'package:Lesaforrit/screens/level_one_finish.dart';
import 'package:Lesaforrit/screens/level_three.dart';
import 'package:Lesaforrit/screens/level_three_finish.dart';
import 'package:Lesaforrit/screens/level_three_short.dart';
import 'package:Lesaforrit/screens/level_three_short_finish.dart';
import 'package:Lesaforrit/screens/level_two.dart';
import 'package:Lesaforrit/screens/level_two_finish.dart';
import 'package:Lesaforrit/screens/level_two_short.dart';
import 'package:Lesaforrit/screens/level_two_short_finish.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/my_profile.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/screens/wrapper.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        print("at / place");
        return MaterialPageRoute(
          builder: (_) => Wrapper(),
        );
      case '/login':
        print("we are here");
        return MaterialPageRoute(
          builder: (_) => SignIn(),
        );
      case '/welcome':
        return MaterialPageRoute(
          builder: (_) => Welcome(),
        );
      case '/lvl_one_choose':
        print("we are here");
        return MaterialPageRoute(
          builder: (_) => LvlOneChoose(),
        );
      default:
        return null;
    }
  }
}

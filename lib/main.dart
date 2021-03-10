import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/models/set_score.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/level_finish.dart';
import 'package:Lesaforrit/screens/level_one_cap.dart';
import 'package:Lesaforrit/screens/level_one_caps_finish.dart';
import 'package:Lesaforrit/screens/level_three.dart';
import 'package:Lesaforrit/screens/level_three_finish.dart';
import 'package:Lesaforrit/screens/level_three_short.dart';
import 'package:Lesaforrit/screens/level_two_finish.dart';
import 'package:Lesaforrit/screens/level_two_short.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/my_profile.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/screens/wrapper.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/levelTemplate.dart';
import 'models/user.dart';
import 'package:Lesaforrit/screens/level_one.dart';
import 'package:Lesaforrit/screens/level_one_finish.dart';
import 'package:Lesaforrit/screens/level_two.dart';

void main() => runApp(Lesapp());

class Lesapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Þurfum að tilgreina hvaða provider við ætlum að hlusta á..
    // Þetta þýðir að öll widgetin fyrir neðan hafa aðgang að gögnum sem koma úr þessum stream.
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFE0FF62), // Litur á appbari uppi
          scaffoldBackgroundColor: Color(0xFFE0FF62), // litur á scaffold niðri
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Wrapper.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          ScoreChart.id: (context) => ScoreChart(),
          LvlOneChoose.id: (context) => LvlOneChoose(),
          LvlTwoChoose.id: (context) => LvlTwoChoose(),
          LvlThreeChoose.id: (context) => LvlThreeChoose(),
          LevelTemplate.id: (context) => LevelTemplate(),
          LevelOne.id: (context) => LevelOne(),
          LevelOneCap.id: (context) => LevelOneCap(),
          LevelTwo.id: (context) => LevelTwo(),
          LevelTwoShort.id: (context) => LevelTwoShort(),
          LevelFinish.id: (context) => LevelFinish(),
          LevelThree.id: (context) => LevelThree(),
          LevelThreeShort.id: (context) => LevelThreeShort(),
          OneFinish.id: (context) => OneFinish(),
          OneCapsFinish.id: (context) => OneCapsFinish(),
          TwoFinish.id: (context) => TwoFinish(),
          ThreeFinish.id: (context) => ThreeFinish(),
          SignIn.id: (context) => SignIn(),
          Register.id: (context) => Register(),
          Wrapper.id: (context) => Wrapper(),
          ProfileView.id: (context) => ProfileView(),
          MyProfile.id: (context) => MyProfile(),
          SetScore.id: (context) => SetScore(),
        },
      ),
    );
  }
}

import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/models/usr.dart' as usr;
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/database/database_bloc.dart';
import '../bloc/user/authentication_bloc.dart';
import '../models/UserData.dart';
import '../models/UserScore.dart';

class MyProfile extends StatefulWidget {
  static const String id = 'my_profile';
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String currentName;
  String currentScore;
  String currentAge;
  String currentReadingStage;

  UserData userData =
      UserData(name: 'name', age: 'age', readingStage: 'readingState');
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _database = RepositoryProvider.of<DatabaseService>(context);

    return (BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationLoading) {
        print("loading going on");
        return Loading();
      }
      if (state is UserUid) {
        final _databaseService = DatabaseService(uid: state.uid);
        return BlocProvider<DatabaseBloc>(create: (context) {
          return DatabaseBloc(_databaseService)..add(GetUserData());
        }, child:
            BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
          if (state is DatabaseLoading) {
            print("loading going on");
            return Loading();
          }
          if (state is UserDataState) {
            return Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        //alignment: Alignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 190,
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Divider(
                                  color: blai,
                                  indent: 140,
                                  endIndent: 140,
                                  thickness: 1.3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.userdata.name,
                                    style: myPagesName,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Divider(
                                    color: blai,
                                    indent: 140,
                                    endIndent: 140,
                                    thickness: 1.3),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Aldur: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    state.userdata.age,
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lestrarstig: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    state.userdata.readingStage,
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\nStigamet ',
                                    style: myPagesBold,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Divider(
                                  color: blai,
                                  indent: 140,
                                  endIndent: 140,
                                  thickness: 1.3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'H??stafir: ',
                                    style: myPages,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    // userData.lvlOneCapsScore
                                    "${state.userscore.lvlOneCapsScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'L??gstafir: ',
                                    style: myPages,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    // userData.lvlOneScore
                                    "${state.userscore.lvlOneScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur stafa: ',
                                    style: myPages,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    // userData.lvlOneVoiceScore
                                    "${state.userscore.lvlOneVoiceScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Stutt or??: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoEasyScore
                                    "${state.userscore.lvlTwoEasyScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'L??ng or??: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoMediumScore
                                    "${state.userscore.lvlTwoMediumScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur or??a: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoVoiceScore
                                    "${state.userscore.lvlTwoVoiceScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Stuttar setningar: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlThreeEasyScore
                                    "${state.userscore.lvlThreeEasyScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Langar setningar: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlThreeMediumScore
                                    "${state.userscore.lvlThreeMediumScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur setninga: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlThreeVoiceScore
                                    "${state.userscore.lvlThreeVoiceScore}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Divider(
                                  color: blai,
                                  indent: 140,
                                  endIndent: 140,
                                  thickness: 1.3),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: BottomBar(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          image: 'assets/images/bottomBar_ye.png'),
                    ),
                  ],
                ),
              ),
            );
            // return Loading();
          }
          print("mid loading");
          return Loading();
        }));
      }
      print("bottom loading");
      return Loading();
    }));
  }
}

class Div extends StatelessWidget {
  final double bottom;
  final double top;

  Div({this.bottom, this.top});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: Divider(
          color: cardColorLvlThree, indent: 53, endIndent: 60, thickness: 1.7),
    );
  }
}

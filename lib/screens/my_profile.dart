import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/database/database_bloc.dart';
import '../bloc/user/authentication_bloc.dart';
import '../models/UserData.dart';

class MyProfile extends StatefulWidget {
  static const String id = 'my_profile';
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();

  // form values
  late String currentName;
  late String currentScore;
  late String currentAge;
  late String currentReadingStage;

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
                              child: Container(
                                color: Colors.black54,
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
                                    state.userdata.age ?? 'Ekki skilgreint',
                                    style: myPages,
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       'Lestrarstig: ',
                              //       style: myPages,
                              //     ),
                              //     Text(
                              //       state.userdata.readingStage,
                              //       style: myPages,
                              //     ),
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Skóli: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    state.school,
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Bekkur: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    state.userdata.classname ??
                                        'Ekki skilgreint',
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
                                    'Hástafir: ',
                                    style: myPages,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    // userData.lvlOneCapsScore
                                    "${state.userscore.lvlOneCapsScore?.toInt() ?? 0}}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lágstafir: ',
                                    style: myPages,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    // userData.lvlOneScore
                                    "${state.userscore.lvlOneScore?.toInt() ?? 0}",
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
                                    "${state.userscore.lvlOneVoiceScore?.toInt()}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Stutt orð: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoEasyScore
                                    "${state.userscore.lvlTwoEasyScore?.toInt() ?? 0}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Löng orð: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoMediumScore
                                    "${state.userscore.lvlTwoMediumScore?.toInt() ?? 0}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur stuttra orða: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoVoiceScore
                                    "${state.userscore.lvlTwoVoiceScore?.toInt() ?? 0}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur lengri orða: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlTwoVoiceScore
                                    "${state.userscore.lvlTwoVoiceMediumScore?.toInt() ?? 0}",
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
                                    "${state.userscore.lvlThreeEasyScore?.toInt() ?? 0}",
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
                                    "${state.userscore.lvlThreeMediumScore?.toInt() ?? 0}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur stuttra setninga: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlThreeVoiceScore
                                    "${state.userscore.lvlThreeVoiceScore?.toInt() ?? 0}",
                                    style: myPages,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upplestur lengri setninga: ',
                                    style: myPages,
                                  ),
                                  Text(
                                    // userData.lvlThreeVoiceScore
                                    "${state.userscore.lvlThreeVoiceMediumScore?.toInt() ?? 0}",
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
  final double? bottom;
  final double? top;

  Div({this.bottom, this.top});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom ?? 5, top: top ?? 5),
      child: Divider(
          color: cardColorLvlThree, indent: 53, endIndent: 60, thickness: 1.7),
    );
  }
}

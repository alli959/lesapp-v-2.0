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
            return StreamBuilder<UserData>(
                stream: state.userdata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    this.userData = snapshot.data;
                  }
                  print("top loading");
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userData.name,
                                          style: myPagesName,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Divider(
                                          color: blai,
                                          indent: 140,
                                          endIndent: 140,
                                          thickness: 1.3),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Aldur: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          userData.age,
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Lestrarstig: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          userData.readingStage,
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Hástafir: ',
                                          style: myPages,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          // userData.lvlOneCapsScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Lágstafir: ',
                                          style: myPages,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          // userData.lvlOneScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upplestur stafa: ',
                                          style: myPages,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          // userData.lvlOneVoiceScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Stutt orð: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          // userData.lvlTwoEasyScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Löng orð: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          // userData.lvlTwoMediumScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upplestur orða: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          // userData.lvlTwoVoiceScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Stuttar setningar: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          // userData.lvlThreeEasyScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Langar setningar: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          // userData.lvlThreeMediumScore
                                          "0",
                                          style: myPages,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upplestur setninga: ',
                                          style: myPages,
                                        ),
                                        Text(
                                          // userData.lvlThreeVoiceScore
                                          "0",
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
                });
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

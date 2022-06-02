import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/screens/home/user_list.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/models/read.dart';

import '../../bloc/database/database_bloc.dart';
import '../../shared/loading.dart';

class ScoreChart extends StatelessWidget {
  static const String id = 'scorechart';
  final Color buttonColour = Colors.black;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Everytime there is a change in the database we are gonna receive a list of Reads and theire gonna reflect the reads currently in the Firestore collection
    return BlocProvider<AuthenticationBloc>(create: (context) {
      final _authService = RepositoryProvider.of<AuthService>(context);
      return AuthenticationBloc(_authService)..add(GetUid());
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationLoading) {
        print("loading goint on");
        return Loading();
      }
      if (state is UserUid) {
        print("UserScoreUpdate going on");
        return BlocProvider<DatabaseBloc>(create: (context) {
          final _databaseService = DatabaseService(uid: state.uid);
          return DatabaseBloc(_databaseService)..add(GetUsers());
        }, child:
            BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
          if (state is DatabaseLoading) {
            print("loading going on");
            return Loading();
          }
          if (state is UsersState) {
            print("state of users are ${state.users}");
            return (StreamProvider<List<Read>>.value(
              value: state.users,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: appBar,
                  title: Text('Stigatafla'),
                ),
                endDrawer: SideMenu(),
                body: Column(
                  children: <Widget>[
                    Expanded(child: UserList()),
                    Container(
                      child: BottomBar(
                          onTap: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/wrapper'));
                          },
                          image: 'assets/images/bottomBar_ye.png'),
                    ),
                  ],
                ),
              ),
            ));
          }
          return Loading();
        }));
      }
      return Loading();
    }));
  }
}

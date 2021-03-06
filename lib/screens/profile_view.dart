import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/screens/my_profile.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/authentication_bloc.dart';

class ProfileView extends StatelessWidget {
  static const String id = 'profile view';
  final AuthService _auth = AuthService();
  final DatabaseService data = DatabaseService();
  final UserData user = UserData();
  final Read read = Read();
  @override
  Widget build(BuildContext context) {
    //final users = Provider.of<List<Read>>(context) ?? []; // fæ villu

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[],
        title: Text('Mínar síður'),
        backgroundColor: appBar,
      ),
      endDrawer: SideMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // ætti að miðjusetja allt
                // height: MediaQuery.of(context).size.height,
                child: BlocProvider<AuthenticationBloc>(
                  create: (context) {
                    final _authService =
                        RepositoryProvider.of<AuthService>(context);
                    return AuthenticationBloc(_authService)..add(GetUid());
                  },
                  child: MyProfile(),
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/screens/home/user_list.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/models/read.dart';

class ScoreChart extends StatelessWidget {
  static const String id = 'scorechart';
  final Color buttonColour = Colors.black;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Everytime there is a change in the database we are gonna receive a list of Reads and theire gonna reflect the reads currently in the Firestore collection
    return StreamProvider<List<Read>>.value(
      value: DatabaseService().users,
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
                    Navigator.pop(context);
                  },
                  image: 'assets/images/bottomBar_ye.png'),
            ),
          ],
        ),
      ),
    );
  }
}

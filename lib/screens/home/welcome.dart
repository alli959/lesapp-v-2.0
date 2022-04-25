import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/components/img_button.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/screens/authenticate/authenticate.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/wrapper.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:imagebutton/imagebutton.dart';

class Welcome extends StatelessWidget {
  static const String id = 'welcome';
  final Color buttonColour = Colors.black;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _onLogoutButtonPressed() {
      _authBloc.add(UserLoggedOut());
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationUnauthenticated) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Wrapper.id, (Route<dynamic> route) => false);
      }
      return BlocProvider<DatabaseBloc>(
          create: (context) {
            final databaseService =
                RepositoryProvider.of<DatabaseService>(context);
            return DatabaseBloc(databaseService);
          },
          child: Scaffold(
            // backgroundColor: Color(0xFFE0FF62),
            appBar: AppBar(
              backgroundColor: appBar,
              elevation: 20,
              leading: Container(
                padding: EdgeInsets.only(left: 6, top: 5),
                child: ImageButton(
                  children: <Widget>[],
                  width: 25,
                  height: 25,
                  pressedImage: Image.asset('assets/images/logout.png'),
                  unpressedImage: Image.asset('assets/images/logout.png'),
                  onTap: () async {
                    if (_auth.getCurrentUser() == null) {
                      print('Usr = null');
                    } else
                      _onLogoutButtonPressed();
                  },
                  label: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 2),
                    child: Text(
                      'Útskrá',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              title: Text('LesApp', style: TextStyle(color: Colors.black)),
              iconTheme: IconThemeData(size: 40, color: Colors.black),
            ),
            endDrawer: SideMenu(),
            body: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Column(
                children: <Widget>[
                  Expanded(flex: 2, child: Image.asset('assets/images/wc.png')),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: ImgButton(
                                left: 0,
                                top: 28,
                                right: 0,
                                bottom: 0,
                                width: 120,
                                height: 139,
                                firstImage: 'assets/images/takkar_bord-1.png',
                                secondImage: 'assets/images/takkar_bord-1.png',
                                onTap: () {
                                  // Navigator.of(context).pushNamed(
                                  //   LvlOneChoose.id,
                                  // );
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LvlOneChoose()),
                                  //     (Route<dynamic> route) => false);
                                  // Navigator.of(context).pushNamedAndRemoveUntil(
                                  //     LvlOneChoose.id,
                                  //     (Route<dynamic> route) => false);
                                  // Navigator.pushNamed(context, LvlOneChoose.id);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      LvlOneChoose.id,
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: ImgButton(
                                left: 0,
                                top: 28,
                                right: 0,
                                bottom: 0,
                                width: 120,
                                height: 139,
                                firstImage: 'assets/images/takkar_bord-2.png',
                                secondImage: 'assets/images/takkar_bord-2.png',
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      LvlTwoChoose.id,
                                      (Route<dynamic> route) => false);
                                  // Navigator.pushNamed(context, LvlTwoChoose.id);
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: ImgButton(
                                left: 0,
                                top: 27,
                                right: 0,
                                bottom: 0,
                                width: 120,
                                height: 139,
                                firstImage: 'assets/images/takkar_bord-3.png',
                                secondImage: 'assets/images/takkar_bord-3.png',
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      LvlThreeChoose.id,
                                      (Route<dynamic> route) => false);
                                  //  Navigator.pushNamed(context, LvlThreeChoose.id);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
   
    // final user = BlocConsumer.of<AuthenticationBloc>(context);
    // Everytime there is a change in the database we are gonna receive a list of Reads and theire gonna reflect the reads currently in the Firestore collection

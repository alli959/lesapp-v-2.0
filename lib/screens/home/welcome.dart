import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        elevation: 20,
        leading: Container(
          padding: EdgeInsets.only(left: 6, top: 5),
          child: GestureDetector(
            onTap: () async {
              _onLogoutButtonPressed();
            },
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/logout.png', width: 25, height: 25),
                Text(
                  'Útskrá',
                  style: TextStyle(color: Colors.black),
                ),
              ],
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
                  buildImageButton(
                    context,
                    'assets/images/takkar_bord-1.png',
                    LvlOneChoose.id,
                  ),
                  buildImageButton(
                    context,
                    'assets/images/takkar_bord-2.png',
                    LvlTwoChoose.id,
                  ),
                  buildImageButton(
                    context,
                    'assets/images/takkar_bord-3.png',
                    LvlThreeChoose.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageButton(
      BuildContext context, String imagePath, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          route,
          (Route<dynamic> route) => false,
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 120,
        height: 139,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

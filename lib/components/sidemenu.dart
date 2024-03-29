import 'package:Lesaforrit/components/img_button.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';

import '../screens/settings.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Container(
        color: guli,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 40),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 600),
                child: SizedBox(
                  height: null,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Tile(
                            title: 'Heim',
                            icons: Icons.home,
                            navigation: Welcome(),
                            nav: '',
                          ),
                        ),
                        Expanded(
                          child: Tile(
                            title: 'Mínar síður',
                            icons: Icons.face,
                            navigation: ProfileView(),
                            nav: '',
                          ),
                        ),
                        Expanded(
                          child: Tile(
                            title: 'Stillingar',
                            icons: Icons.settings,
                            navigation: Settings(),
                            nav: '',
                          ),
                        ),
                        Expanded(
                            child: Stack(children: <Widget>[
                          Tile(
                            title: 'Notanda Stillingar',
                            icons: Icons.account_box,
                            navigation: Settings(specialScreen: false),
                            nav: '',
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            widthFactor: 3.9,
                            heightFactor: 5,
                            child: Icon(Icons.settings,
                                size: 27, color: Colors.grey[700]),
                          ),
                        ])),
                        Div(bottom: 0, top: 0),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 56),
                                child: Text(
                                  'Leikir',
                                  style: TextStyle(
                                      fontFamily: 'Metropolis-Regular.otf',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Div(bottom: 14, top: 0),
                        Expanded(
                          child: ImgTile(
                            title: 'Stafir',
                            navigation: LvlOneChoose.id,
                            imgOne: 'assets/images/level_buttons-1.png',
                            imgTwo: 'assets/images/level_buttons-1.png',
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  LvlOneChoose.id,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                        Expanded(
                          child: ImgTile(
                            title: 'Orð',
                            navigation: LvlTwoChoose.id,
                            imgOne: 'assets/images/level_buttons-2.png',
                            imgTwo: 'assets/images/level_buttons-2.png',
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  LvlThreeChoose.id,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                        Expanded(
                          child: ImgTile(
                            title: 'Setningar',
                            navigation: LvlThreeChoose.id,
                            imgOne: 'assets/images/level_buttons-3.png',
                            imgTwo: 'assets/images/level_buttons-3.png',
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  LvlThreeChoose.id,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Div extends StatelessWidget {
  final double bottom;
  final double top;

  Div({required this.bottom, required this.top});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: Divider(color: blai, indent: 53, endIndent: 60, thickness: 1.9),
    );
  }
}

class NavigationScreen extends StatelessWidget {
  final Widget nav;

  NavigationScreen({required this.nav});

  @override
  Widget build(BuildContext context) {
    return nav;
  }
}

class Tile extends StatelessWidget {
  final String title;
  final IconData icons;
  final Widget navigation;
  final String nav;

  Tile(
      {required this.title,
      required this.icons,
      required this.navigation,
      required this.nav});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(35, 0, 0, 0),
      title: Text(title, style: sideBarText),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NavigationScreen(nav: navigation)));
      },
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                offset: Offset(2.0, 3.0),
                blurRadius: 4,
                color: Color(0xFFb9c95d),
                spreadRadius: 1.5)
          ],
        ),
        child: RoundIconButton(
          iconSize: 37,
          circleSize: 60,
          color: Colors.white,
          icon: icons,
          size: null,
        ),
      ),
    );
  }
}

class ImgTile extends StatelessWidget {
  final String title;
  final String navigation;
  final String imgOne;
  final String imgTwo;
  final Function onTap;

  ImgTile({
    required this.title,
    required this.navigation,
    required this.imgOne,
    required this.imgTwo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 0, left: 37),
      title: Padding(
        padding: const EdgeInsets.only(left: 17),
        child: Text(title, style: sideBarText),
      ),
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            navigation, (Route<dynamic> route) => false);
      },
      /* Gamla aðferðin sem hreinsar ekki stack
              Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NavigationScreen(nav: navigation)));
       */
      leading: Container(
        child: ImgButton(
          left: 14,
          top: 0,
          right: 0,
          bottom: 0,
          width: 56,
          height: 56,
          firstImage: imgOne,
          secondImage: imgTwo,
          onTap: onTap,
        ),
      ),
    );
  }
}

import 'package:Lesaforrit/components/img_button.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Container(
        color: guli,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: guli,
              ),
            ),
            Tile(
              title: 'Heim',
              icons: Icons.home,
              navigation: Welcome(),
            ),
            Tile(
              title: 'Mínar síður',
              icons: Icons.face,
              navigation: ProfileView(),
            ),
            Tile(
              title: 'Stigatafla',
              icons: Icons.people,
              navigation: ScoreChart(),
            ),
            Div(bottom: 0, top: 20),
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
            ImgTile(
              title: 'Stafir',
              navigation: LvlOneChoose(),
              imgOne: 'assets/images/level_buttons-1.png',
              imgTwo: 'assets/images/level_buttons-1.png',
              onTap: () {
                //Navigator.pushNamed(context, LvlOneChoose.id); // held það breyti engu að hafa skipt yfir í neðri setningu.
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LvlOneChoose.id, (Route<dynamic> route) => false);
              },
            ),
            ImgTile(
              title: 'Orð',
              navigation: LvlTwoChoose(),
              imgOne: 'assets/images/level_buttons-2.png',
              imgTwo: 'assets/images/level_buttons-2.png',
              onTap: () {
                // Navigator.pushNamed(context, LvlTwoChoose.id);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LvlTwoChoose.id, (Route<dynamic> route) => false);
              },
            ),
            ImgTile(
              title: 'Setningar',
              navigation: LvlThreeChoose(),
              imgOne: 'assets/images/level_buttons-3.png',
              imgTwo: 'assets/images/level_buttons-3.png',
              onTap: () {
                // Navigator.pushNamed(context, LvlThreeChoose.id);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LvlThreeChoose.id, (Route<dynamic> route) => false);
              },
            ),
            RoundIconButton(
              color: Colors.transparent,
              icon: Icons.settings,
              iconSize: 35,
              circleSize: 55,
              onPressed: () => print("settingsbutton pressed"),
            ),
          ],
        ),
      ),
    );
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
      child: Divider(color: blai, indent: 53, endIndent: 60, thickness: 1.7),
    );
  }
}

class NavigationScreen extends StatelessWidget {
  final Widget nav;

  NavigationScreen({this.nav});

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

  Tile({this.title, this.icons, this.navigation, this.nav});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(35, 0, 0, 20),
      title: Text(title, style: sideBarText),
      onTap: () {
        //Navigator.of(context).pop();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(nav, (Route<dynamic> route) => false);
      },
      /*
      Fyrri aðferð áður en ég reyndi að hreinsa Stack en það virkar ekki
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NavigationScreen(nav: navigation)));
      },*/
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
  final Widget navigation;
  final String imgOne;
  final String imgTwo;
  final Function onTap;

  ImgTile({
    this.title,
    this.navigation,
    this.imgOne,
    this.imgTwo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 20, left: 37),
      title: Padding(
        padding: const EdgeInsets.only(left: 17),
        child: Text(title, style: sideBarText),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NavigationScreen(nav: navigation)));
      },
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

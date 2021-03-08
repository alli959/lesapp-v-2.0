import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';

class BottomBar extends StatelessWidget {
  BottomBar({@required this.onTap, @required this.image});

  final Function onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Container(
            child: SizedBox(
                height: 95.0,
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.cover)),
          ),
          Center(
            child: Padding(
              // H O M E
              padding: const EdgeInsets.fromLTRB(0, 15, 160, 0),
              child: RoundIconButton(
                icon: Icons.home,
                iconSize: 35,
                circleSize: 55,
                onPressed: () {
                  Navigator.pushNamed(context, Welcome.id);
                },
                size: null,
              ),
            ),
          ),
          Center(
            child: Padding(
              // M Y  P A G E S
              padding: const EdgeInsets.fromLTRB(160, 15, 0, 0),
              child: RoundIconButton(
                icon: Icons.face,
                iconSize: 35,
                circleSize: 55,
                onPressed: () {
                  Navigator.pushNamed(context, ProfileView.id);
                },
                size: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

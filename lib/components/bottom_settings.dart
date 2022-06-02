import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';

class BottomSettings extends StatelessWidget {
  BottomSettings(
      {@required this.onTapApprove,
      @required this.onTapDecline,
      @required this.image});

  final Function onTapApprove;
  final Function onTapDecline;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapApprove,
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
              padding: const EdgeInsets.fromLTRB(0, 0, 160, 40),
              child: RoundIconButton(
                color: Colors.green,
                icon: Icons.check,
                iconSize: 35,
                circleSize: 55,
                onPressed: () {
                  onTapApprove();
                  Navigator.pushNamed(context, Wrapper.id);
                },
                size: null,
              ),
            ),
          ),
          Center(
            child: Padding(
              // M Y  P A G E S
              padding: const EdgeInsets.fromLTRB(160, 0, 0, 40),
              child: RoundIconButton(
                color: Colors.red,
                icon: Icons.exit_to_app,
                iconSize: 35,
                circleSize: 55,
                onPressed: () {
                  onTapDecline();
                  Navigator.pushNamed(context, Wrapper.id);
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

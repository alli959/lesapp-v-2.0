import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';


class Choose extends StatelessWidget {
  static const String id = 'low_or_caps';
  Choose({
    required this.buttonOne,
    required this.buttonTwo,
    required this.buttonThree,
    required this.buttonTextOne,
    required this.buttonTextTwo,
    required this.buttonTextThree,
    required this.appBarText,
    required this.image,
    required this.appBarColor,
  });

  void Function()? buttonOne;
  void Function()? buttonTwo;
  void Function()? buttonThree;
  String buttonTextOne;
  String buttonTextTwo;
  String buttonTextThree;
  String appBarText;
  String image;
  Color appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(appBarText, style: TextStyle(fontSize: 24)),
        iconTheme: IconThemeData(size: 40, color: Colors.white),
      ),
      endDrawer: SideMenu(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(top: 30, bottom: 50),
              width: 200,
              alignment: Alignment.center,
              child: Image.asset(image),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 30),
                      child: RoundedButton(
                        title: buttonTextOne,
                        colour: buttonColorBlue,
                        onPressed: buttonOne,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 30),
                        child: RoundedButton(
                          title: buttonTextTwo,
                          colour: buttonColorBlue,
                          onPressed: buttonTwo,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 30),
                        child: RoundedButton(
                          title: buttonTextThree,
                          colour: buttonColorBlue,
                          onPressed: buttonThree,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomBar(
              onTap: () {
                Navigator.pop(context);
              },
              image: 'assets/images/bottomBar_ye.png'),
        ],
      ),
    );
  }
}

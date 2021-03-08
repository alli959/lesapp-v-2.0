import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/material.dart';

class Choose extends StatelessWidget {
  static const String id = 'low_or_caps';
  Choose({
    this.buttonOne,
    this.buttonTwo,
    this.buttonTextOne,
    this.buttonTextTwo,
    this.appBarText,
    this.image,
    this.appBarColor,
  });

  Function buttonOne;
  Function buttonTwo;
  String buttonTextOne;
  String buttonTextTwo;
  String appBarText;
  String image;
  Color appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(appBarText),
      ),
      endDrawer: SideMenu(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              width: 300,
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
                      constraints: BoxConstraints(minHeight: 40),
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
                        constraints: BoxConstraints(minHeight: 40),
                        child: RoundedButton(
                          title: buttonTextTwo,
                          colour: buttonColorBlue,
                          onPressed: buttonTwo,
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

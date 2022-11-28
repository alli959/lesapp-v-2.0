import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {this.icon,
      this.onPressed,
      this.size,
      this.color,
      this.circleSize,
      this.iconSize});

  final IconData icon;
  final Function onPressed;
  final IconData size;
  final Color color;
  final double circleSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    // return RaisedButton(
    //   padding: EdgeInsets.all(0),
    //   onPressed: onPressed,
    //   disabledColor: color,
    //   child: Container(
    //     constraints: BoxConstraints.tightFor(
    //       width: circleSize,
    //       height: circleSize,
    //     ),
    //     child: Icon(
    //       icon,
    //       size: iconSize,
    //       color: Colors.black,
    //     ),
    //   ),
    //   elevation: 10.0,
    //   color: Colors.white,
    //   shape: CircleBorder(),
    // );

    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
          constraints: BoxConstraints.tightFor(
            width: circleSize,
            height: circleSize,
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          elevation: MaterialStateProperty.all(10.0),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(CircleBorder()),
        ));
  }
}

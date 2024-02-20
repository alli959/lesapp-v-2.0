import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {required this.icon,
      this.onPressed,
      this.size,
      required this.color,
      required this.circleSize,
      required this.iconSize});

  final IconData icon;
  final void Function()? onPressed;
  final IconData? size;
  final Color color;
  final double circleSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({
    required this.colour,
    required this.cardChild,
    this.onPress,
    required this.height,
    required this.width,
  });

  final Color colour;
  final Widget cardChild;
  final void Function()? onPress;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: cardChild,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}

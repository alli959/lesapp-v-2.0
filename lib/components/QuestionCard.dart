import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({
    @required this.cardChild,
    this.onPress,
  });

  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        child: cardChild,
      ),
    );
  }
}

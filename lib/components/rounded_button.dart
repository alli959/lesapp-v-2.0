import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title, required this.colour, required this.onPressed});

  final Color colour;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(32.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 250.0,
          height: 20.0, // breyta hæð seinna
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

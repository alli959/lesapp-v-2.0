import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: guli,
          child: Center(
            child: SpinKitSquareCircle(
              color: blai,
              size: 150.0,
            ),
          ),
          height: 400,
        ),
        Text(
          "Augnablik...",
          style: TextStyle(fontSize: 20),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }
}

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: guli,
      child: Center(
        child: SpinKitSquareCircle(
          color: blai,
          size: 50.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class ImgButton extends StatelessWidget {
  final double width;
  final double height;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final String firstImage;
  final String secondImage;
  final Function onTap;

  const ImgButton(
      {this.width,
      this.height,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.firstImage,
      this.secondImage,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: ImageButton(
        children: <Widget>[],
        width: width,
        height: height,
        pressedImage: Image.asset(firstImage),
        unpressedImage: Image.asset(secondImage),
        onTap: onTap,
      ),
    );
  }
}

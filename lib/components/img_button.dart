import 'package:flutter/material.dart';

class ImgButton extends StatefulWidget {
  final double width;
  final double height;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final String firstImage; // pressedImage
  final String secondImage; // unpressedImage
  final Function onTap;

  const ImgButton({
    required this.width,
    required this.height,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.firstImage,
    required this.secondImage,
    required this.onTap,
  });

  @override
  _ImgButtonState createState() => _ImgButtonState();
}

class _ImgButtonState extends State<ImgButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        widget.left,
        widget.top,
        widget.right,
        widget.bottom,
      ),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Image.asset(
          _isPressed ? widget.firstImage : widget.secondImage,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}

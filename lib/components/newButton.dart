import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:flutter/material.dart';

class newButton extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<newButton> {
  QuizBrain quizBrain = QuizBrain();
  int count = 0;
  bool enabled = true;

  void enableButton() {
    setState(() {
      enabled = true;
      count = 0;
    });
  }

  void disableButton() {
    setState(() {
      enabled = false;
      count = 0;
    });
  }

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void test() {
    if (count < 2) {
      incrementCounter();
      quizBrain.playLocalAsset();
    } else {
      disableButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: enabled ? () => test() : null,
      child: new Text('Button Clicks - ${count}'),
    );
  }
}

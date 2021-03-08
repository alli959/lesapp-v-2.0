import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:flutter/material.dart';

class SoundButton extends StatefulWidget {
  @override
  _SoundButtonState createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  bool enabled = true;
  int soundPress = 0;
  QuizBrain quizBrain = QuizBrain();

  void test() {
    soundPress++;
    if (soundPress > 2) {
      setState(() {
        enabled = false;
        print('S O U N D P R E S S komið yfir :  $soundPress');
      });
    } else {
      quizBrain.playLocalAsset();
      print('S O U N D P R E S S  í lagi :  $soundPress');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundIconButton(
      icon: Icons.volume_down,
      onPressed: !enabled ? null : () => test(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/custom_painter.dart';

class TimerWidget extends StatelessWidget {
  ///In Seconds
  final int time;
  final Color backgroundcolor;

  TimerWidget({@required this.time, @required this.backgroundcolor});
  Widget build(BuildContext context) {
    return CountDownTimer(time: time, backgroundcolor: backgroundcolor);
  }
}

class CountDownTimer extends StatefulWidget {
  // This widget accepts a title
  final int time;
  final Color backgroundcolor;
  CountDownTimer({@required this.time, @required this.backgroundcolor});

  @override
  _CountDownTimerState createState() =>
      _CountDownTimerState(time: time, backgroundcolor: backgroundcolor);
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;
  final int time;
  final Color backgroundcolor;
  _CountDownTimerState({@required this.time, @required this.backgroundcolor});
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.time);
    ThemeData themeData = Theme.of(context);
    return Stack(fit: StackFit.passthrough, children: [
      AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return CustomPaint(
              painter: CustomTimerPainter(
            animation: controller,
            backgroundColor: backgroundcolor,
            color: themeData.indicatorColor,
          ));
        },
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(14, 25, 0, 0),
          child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child) {
                return Text(
                  timerString,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                );
              }))
    ]);
  }
}

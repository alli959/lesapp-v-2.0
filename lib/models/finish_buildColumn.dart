import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:Lesaforrit/models/quiz_brain_voice.dart';
import 'package:Lesaforrit/models/voices/quiz_brain_lvlOne_voice.dart';
import 'package:Lesaforrit/models/voices/quiz_brain_lvlTwo_voice.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'voices/quiz_brain_lvlThree_voice.dart';

class Finish {
  QuizBrain quizBrain = QuizBrain();
  QuizBrainVoice quizBrainVoice = QuizBrainVoice();

  Form FinishMethod(
    String highestScore,
    double stigamet,
    BuildContext context,
    GlobalKey<FormState> formKey,
    String appBarText,
    String image,
    double stig,
    Widget button1,
    Widget button2,
    Widget button3,
    Color appBarColor,
  ) {
    String writePoints() {
      quizBrain.reset();
      quizBrainVoice.reset();
      return stig.toStringAsFixed(0);
    }

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: appBarColor,
          title: Text(appBarText,
              style: TextStyle(fontSize: 22, color: Colors.white)),
        ),
        // endDrawer: SideMenu(),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  highestScore,
                  style: finishSmallText,
                ),
              ),
              Expanded(
                flex: 6,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: writePoints(),
                          style: TextStyle(
                            fontSize: 95,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -6,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '\n Stig!', style: finishSmallText),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 50),
                            child: Container(
                              child: button1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 50),
                            child: Container(
                              child: button2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 50),
                            child: Container(
                              child: button3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 95.0,
                  width: double.infinity,
                  child: Image.asset('assets/images/bottomBar_ye.png',
                      fit: BoxFit.cover)),
            ],
          ),
        ),
      ),
    );
  }
}

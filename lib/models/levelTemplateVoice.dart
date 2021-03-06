import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/timer.dart';

class LevelTemplateVoice extends StatelessWidget {
  static const String id = 'level_template';

  bool isListening = false;
  Function listeningUpdate;
  Function checkAnswer;
  String question;
  String lastWords;
  List<Icon> scoreKeeper;
  int trys;
  String correct;
  String stig;
  Color cardColor;
  Color stigColor;
  double fontSize;
  Widget bottomBar;
  int shadowLevel;
  bool isLetters = false;

  Function ondoneListener;
  Function resultListener;
  List<bool> questionMap = [];
  List<bool> answerMap = [];
  List<String> questionArr = [];
  List<String> answerArr = [];
  bool isShowResult;
  int questionTime = 10;

  LevelTemplateVoice(
      {this.isListening,
      this.questionMap,
      this.answerMap,
      this.questionArr,
      this.answerArr,
      this.listeningUpdate,
      this.checkAnswer,
      this.question,
      this.lastWords,
      this.scoreKeeper,
      this.trys,
      this.correct,
      this.stig,
      this.cardColor,
      this.stigColor,
      this.fontSize,
      this.bottomBar,
      this.shadowLevel,
      this.isLetters,
      this.resultListener,
      this.ondoneListener,
      this.isShowResult,
      this.questionTime});

  List<TextSpan> getResultText(List<String> arr, List<bool> map) {
    List<TextSpan> resultTextMap = [];
    print("arr is $arr");
    print("map is $map");

    // capitalize first letter
    arr[0] = arr[0].substring(0, 1).toUpperCase() + arr[0].substring(1);

    for (var i = 0; i < arr.length; i++) {
      map[i]
          ? resultTextMap.add(TextSpan(
              text: "${arr[i]} ", style: TextStyle(color: Colors.green[900])))
          : resultTextMap.add(TextSpan(
              text: "${arr[i]} ", style: TextStyle(color: Colors.red)));
    }
    return resultTextMap;
  }

  @override
  Widget build(BuildContext context) {
    final _voiceBloc = BlocProvider.of<VoiceBloc>(context);

    _onVoiceButtonPressed() {
      _voiceBloc.add(VoiceStartedEvent(
          doneListener: ondoneListener, resultListener: resultListener));
    }

    _onStopButtonPressed() {
      _voiceBloc.add(VoiceStoppedEvent());
    }

    _onCancelButtonPressed() {
      print("cancelbutton pressed");
      _voiceBloc.add(VoiceCancelEvent());
    }

    return Container(
      // B L ?? A  K O R T I ??
      decoration: BoxDecoration(
        color: cardColor, // - - - * * - - -//
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55), topRight: Radius.circular(55)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.50),
            spreadRadius: 6,
            blurRadius: 15,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // H L J ?? ?? T A K K I /////////////////////////////////////////////////////////////////////////////////////////
        children: <Widget>[
          // E F R I  S T A F U R ////////////////////////////////////////////////////////////////////////
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    child: !isShowResult
                        ? QuestionCard(
                            cardChild: AutoSizeText(
                              question,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Metropolis-Regular.otf',
                                fontWeight: FontWeight.w800,
                                fontSize: fontSize,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 20.0,
                                    color: Color.fromARGB(shadowLevel, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : QuestionCard(
                            cardChild: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    backgroundColor: stigColor,
                                    fontFamily: 'Metropolis-Regular.otf',
                                    fontWeight: FontWeight.w800,
                                    fontSize: fontSize,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 20.0,
                                        color: Color.fromARGB(
                                            shadowLevel, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                  children: (questionArr.length == 0 ||
                                          questionMap.length == 0
                                      ? _onCancelButtonPressed()
                                      : getResultText(
                                          questionArr, questionMap))),
                            ),
                          )),
              ],
            ),
          ),

          // SVARI??
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    child: !isShowResult
                        ? QuestionCard(
                            cardChild: AutoSizeText(
                              lastWords,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Metropolis-Regular.otf',
                                fontWeight: FontWeight.w800,
                                fontSize: fontSize,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 20.0,
                                    color: Color.fromARGB(shadowLevel, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : QuestionCard(
                            cardChild: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    backgroundColor: stigColor,
                                    fontFamily: 'Metropolis-Regular.otf',
                                    fontWeight: FontWeight.w800,
                                    fontSize: fontSize,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 20.0,
                                        color: Color.fromARGB(
                                            shadowLevel, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                  children: (answerArr.length == 0 ||
                                          answerMap.length == null
                                      ? _onCancelButtonPressed()
                                      : getResultText(answerArr, answerMap))),
                            ),
                          )),
              ],
            ),
          ),

          // // animation
          // Expanded(
          //   child: Stack(
          //     children: [
          //       BlocBuilder<VoiceBloc, VoiceState>(builder: (context, state) {
          //         if (state is CorrectAnimation) {
          //           print("CORRECTANIMATION");
          //           return Stack(children: state.animation);
          //         }
          //         return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: SizedBox.shrink());
          //       }),
          //     ],
          //   ),
          // ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // F J ?? L D I   R ?? T T   G I S K A ?? / Tilraunir
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 17, bottom: 15, top: 0),
                      child: ReusableCard(
                        height: 35,
                        colour: stigColor, // - - - * * - - -//
                        cardChild: isLetters == true
                            ? Text(
                                'R??ttir Stafir:  ' +
                                    correct +
                                    ' af ' +
                                    trys.toString(),
                                style: correctTrys,
                              )
                            : Text(
                                'R??tt Or??:  ' +
                                    correct +
                                    ' af ' +
                                    trys.toString(),
                                style: correctTrys,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      // S T I G
                      padding: const EdgeInsets.only(
                          left: 15, right: 25, bottom: 15, top: 0),
                      child: ReusableCard(
                        height: 35,
                        colour: stigColor, // - - - * * - - -//
                        cardChild: Text(stig, style: points),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 24.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: 35, minHeight: 34),
                            child: SizedBox(
                              height: 35,
                              child: Container(
                                child: ReusableCard(
                                  colour: Colors.white,
                                  cardChild: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: scoreKeeper,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          isListening
              ? Column(children: <Widget>[
                  Row(children: [
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Container(
                        child: RoundIconButton(
                          color: Colors.transparent,
                          icon: Icons.arrow_back,
                          iconSize: 35,
                          circleSize: 55,
                          onPressed: () =>
                              !isShowResult ? _onCancelButtonPressed() : {},
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 2,
                        child: SizedBox(
                            height: 70,
                            width: 70,
                            child: TimerWidget(
                              time: questionTime,
                              backgroundcolor: cardColor,
                              onTimeStop: _onStopButtonPressed,
                              onTimeCancel: _onCancelButtonPressed,
                            ))),
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Container(
                        child: RoundIconButton(
                          color: Colors.transparent,
                          icon: Icons.stop,
                          iconSize: 35,
                          circleSize: 55,
                          onPressed: () =>
                              !isShowResult ? _onStopButtonPressed() : {},
                        ),
                      ),
                    )
                  ]),
                  Container(
                      child: Stack(children: [
                    SizedBox(
                        height: 95.0,
                        width: double.infinity,
                        child: Image.asset('assets/images/bottomBar_bl.png',
                            fit: BoxFit.cover)),
                  ]))
                ])
              : Column(children: [
                  RoundIconButton(
                    color: Colors.transparent,
                    icon: Icons.mic,
                    iconSize: 35,
                    circleSize: 55,
                    onPressed: () =>
                        !isShowResult ? _onVoiceButtonPressed() : {},
                  ),
                  bottomBar,
                ]),
        ],
      ),
    );
  }
}

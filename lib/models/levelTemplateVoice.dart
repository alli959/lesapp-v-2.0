import 'dart:typed_data';

import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';

import '../shared/timer.dart';

class LevelTemplateVoice extends StatelessWidget {
  static const String id = 'level_template';

  bool isListening = false;
  final void Function(String, List<SpeechRecognitionAlternative>, bool, String)
      listeningUpdate;
  final void Function(
    bool,
    bool,
    bool,
    bool,
    bool, {
    required String username,
    required String typeoffile,
    required String question,
    required String answer,
    required Uint8List audio,
    required int trys,
    required int correct,
  }) checkAnswer;

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

  void Function() ondoneListener;
  void Function(StreamingRecognizeResponse) resultListener;
  List<bool> questionMap = [];
  List<bool> answerMap = [];
  List<String> questionArr = [];
  List<String> answerArr = [];
  bool isShowResult;
  int questionTime = 10;

  LevelTemplateVoice(
      {required this.isListening,
      required this.questionMap,
      required this.answerMap,
      required this.questionArr,
      required this.answerArr,
      required this.listeningUpdate,
      required this.checkAnswer,
      required this.question,
      required this.lastWords,
      required this.scoreKeeper,
      required this.trys,
      required this.correct,
      required this.stig,
      required this.cardColor,
      required this.stigColor,
      required this.fontSize,
      required this.bottomBar,
      required this.shadowLevel,
      required this.isLetters,
      required this.resultListener,
      required this.ondoneListener,
      required this.isShowResult,
      required this.questionTime});

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
      // B L Á A  K O R T I Ð
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
        // H L J Ó Ð T A K K I /////////////////////////////////////////////////////////////////////////////////////////
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

          // SVARIÐ
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    child: !isShowResult
                        ? BlocBuilder<VoiceBloc, VoiceState>(
                            builder: (context, state) {
                            if (state is AnswerCleanedState) {
                              lastWords = "";
                              return QuestionCard(
                                cardChild: AutoSizeText(
                                  "",
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
                                        color: Color.fromARGB(
                                            shadowLevel, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return QuestionCard(
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
                                      color:
                                          Color.fromARGB(shadowLevel, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
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
                                  children: (answerArr.length == 0
                                      ? _onCancelButtonPressed()
                                      : getResultText(answerArr, answerMap))),
                            ),
                          )),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // F J Ö L D I   R É T T   G I S K A Ð / Tilraunir
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 17, bottom: 15, top: 0),
                      child: ReusableCard(
                        height: 35,
                        width: 100,
                        colour: stigColor, // - - - * * - - -//
                        cardChild: isLetters == true
                            ? Text(
                                'Réttir Stafir:  ' +
                                    correct +
                                    ' af ' +
                                    trys.toString(),
                                style: correctTrys,
                              )
                            : Text(
                                'Rétt Orð:  ' +
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
                        width: 100,
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
                                  height: 35,
                                  colour: Colors.white,
                                  width: 300,
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
                          color: Colors.white,
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
                          color: Colors.white,
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
                    color: Colors.white,
                    icon: Icons.mic,
                    iconSize: 50,
                    circleSize: 70,
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

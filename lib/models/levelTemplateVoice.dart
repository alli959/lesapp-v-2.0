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

class LevelTemplateVoice extends StatelessWidget {
  static const String id = 'level_template';
  Function listeningUpdate;
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

  LevelTemplateVoice(
      {this.listeningUpdate,
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
      this.shadowLevel});

  @override
  Widget build(BuildContext context) {
    final _voiceBloc = BlocProvider.of<VoiceBloc>(context);

    _onVoiceButtonPressed() {
      _voiceBloc.add(VoiceStartedEvent(callback: listeningUpdate));
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
                  child: BlocBuilder<VoiceBloc, VoiceState>(
                    builder: (context, state) {
                      if (state is NewQuestionState) {
                        return QuestionCard(
                          cardChild: AutoSizeText(
                            state.question,
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
                        );
                      }
                      return QuestionCard(
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
                      );
                    },
                  ),
                ),
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
                  child: BlocBuilder<VoiceBloc, VoiceState>(
                    builder: (context, state) {
                      if (state is UpdateState) {
                        return QuestionCard(
                          cardChild: AutoSizeText(
                            state.lastWords,
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
                        );
                      }
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
                                color: Color.fromARGB(shadowLevel, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                        colour: stigColor, // - - - * * - - -//
                        cardChild: Text(
                          'RÉTT :  ' + correct + ' af ' + trys.toString(),
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
          Container(
            child: Column(children: <Widget>[
              bottomBar,
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () => _onVoiceButtonPressed(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

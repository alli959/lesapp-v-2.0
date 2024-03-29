import 'package:Lesaforrit/components/QuestionCard.dart';
import 'package:Lesaforrit/components/reusable_card.dart';
import 'package:Lesaforrit/components/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LevelTemplate extends StatelessWidget {
  static const String id = 'level_template';

  final double soundCircleSize;
  final double soundPad;
  final double soundPadBottom;
  final double soundIconSize;
  final bool enabled;
  final String upperLetterImage;
  final String lowerLetterImage;
  String letterOne;
  String letterTwo;
  void Function()? onPressed;
  void Function()? onPressed2;
  void Function()? onPress;
  void Function()? onPress2;
  void Function()? onPlay;
  final List<Icon> scoreKeeper;
  final String trys;
  final String correct;
  final String stig;
  final Color cardColor;
  final Color stigColor;
  final double fontSize;
  final Widget bottomBar;
  final int shadowLevel;

  LevelTemplate({
    this.soundCircleSize = 100,
    this.soundPad = 0.0,
    this.soundPadBottom = 10,
    this.soundIconSize = 35,
    this.enabled = true,
    this.upperLetterImage = 'assets/images/empty.png',
    this.lowerLetterImage = 'assets/images/empty.png',
    this.letterOne = '',
    this.letterTwo = '',
    this.onPressed,
    this.onPressed2,
    this.onPress,
    this.onPress2,
    this.onPlay,
    this.scoreKeeper = const [],
    this.trys = '',
    this.correct = '',
    this.stig = '',
    this.cardColor = Colors.white,
    this.stigColor = Colors.white,
    this.fontSize = 0,
    this.bottomBar = const SizedBox.shrink(),
    this.shadowLevel = 0,
  });

  @override
  Widget build(BuildContext context) {
    //Making sure that the first letter of every letter/word/sentence is large

    this.letterOne = this.letterOne.length > 1
        ? this.letterOne[0].toUpperCase() + this.letterOne.substring(1)
        : this.letterOne;
    this.letterTwo = this.letterTwo.length > 1
        ? this.letterTwo[0].toUpperCase() + this.letterTwo.substring(1)
        : this.letterTwo;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, soundPad + 25, 0, soundPadBottom),
                  child: letterOne.length == 0
                      ? Column(children: [
                          RoundIconButton(
                            icon: Icons.play_arrow_rounded,
                            iconSize: soundIconSize,
                            circleSize: soundCircleSize,
                            onPressed: onPlay,
                            color: Colors.white,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Ýttu á takka til að hefja leik',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ))
                        ])
                      : Container(
                          decoration: BoxDecoration(
                              color: stigColor,
                              border: Border.all(
                                color: stigColor,
                                width: 5,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Stack(children: <Widget>[
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 140, 0),
                                child: InkWell(
                                  onTap: onPressed,
                                  child: Image.asset(
                                    'assets/icons/woman_speaking.png',
                                    width: 75,
                                    height: 75,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(140, 0, 0, 0),
                                child: InkWell(
                                  onTap: onPressed2,
                                  child: Image.asset(
                                    'assets/icons/man_speaking.png',
                                    width: 75,
                                    height: 75,
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ))
            ],
          ),

          // E F R I  S T A F U R ////////////////////////////////////////////////////////////////////////
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(upperLetterImage, fit: BoxFit.contain),
                ),
                Container(
                  child: QuestionCard(
                    cardChild: AutoSizeText(
                      letterOne,
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
                    onPress: onPress,
                  ),
                ),
              ],
            ),
          ),
          // N E D R I  S T A F U R ////////////////////////////////////////////////////////////////////////
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(lowerLetterImage, fit: BoxFit.contain),
                ),
                Container(
                  child: QuestionCard(
                    cardChild: AutoSizeText(
                      letterTwo,
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
                    onPress: onPress2,
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
                        width: 100,
                        cardChild: Text(
                          'RÉTT :  ' + correct + ' af ' + trys,
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
                        width: 100,
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
                                  height: 35,
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
          Container(
            child: bottomBar,
          ),
        ],
      ),
    );
  }
}

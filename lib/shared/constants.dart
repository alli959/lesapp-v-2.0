import 'package:flutter/material.dart';

/* Litir:
Color(0xFF81FFE9); Blái
Color(0xFF009df4); skærbláar stjörnur
 */

const appBar = Color.fromARGB(255, 235, 255, 66);
const guli = Color.fromRGBO(224, 255, 98, 1);
const blai = Color(0xFF81FFE9);
const kBottomContainerHeight = 100.0; //
const kActiveCardColour = Color(0xFF81FFE9);
const kInactiveCardColour = Color(0xFF81FFE9);
const kBottomContainerColour = Color(0xFF81FFE9); // blai
const cardColor = Color(0xFF81FFE9);
const cardColorCaps = Color(0xFFadffdd);
const cardColorLvlTwo = Color(0xFF57ff9b);
const cardColorLvlThree = Color(0xFF00c3ff);
const lightCyan = Color(0xFFa7ffeb);
const lightGreen = Color(0xFF8fffa5);
const lightBlue = Color(0xFF54d7ff);
const letterColor = Colors.black;
const buttonColor = Colors.black;
const buttonColorBlue = Color(0xFF009df4);
const wrong = Color(0xFFfa2545);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const quesText = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontWeight: FontWeight.w800,
  fontSize: 140.0,
  color: letterColor,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(3.0, 3.0),
      blurRadius: 25.0,
      color: Color.fromARGB(145, 0, 0, 0),
    ),
  ],
);

const quesTextLvlTwo = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontWeight: FontWeight.w800,
  fontSize: 80.0,
  color: Colors.black,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(3.0, 3.0),
      blurRadius: 25.0,
      color: Color.fromARGB(145, 0, 0, 0),
    ),
  ],
);

const breadText = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const correctTrys = TextStyle(
  letterSpacing: -1,
  fontFamily: 'Metropolis-Regular.otf',
  fontWeight: FontWeight.w600,
  fontSize: 18,
  color: Colors.black,
);

const points = TextStyle(
  letterSpacing: -0.4,
  fontFamily: 'Metropolis-Regular.otf',
  fontWeight: FontWeight.w600,
  fontSize: 18,
  color: Colors.black,
);

const sideBarText = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const finishSmallText = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 24,
  letterSpacing: -1,
);

const myPages = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontSize: 16.2,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

const myPagesBold = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontSize: 18.0,
  fontWeight: FontWeight.w800,
  color: Colors.white,
);

const myPagesName = TextStyle(
  fontFamily: 'Metropolis-Regular.otf',
  fontSize: 22.0,
  fontWeight: FontWeight.w800,
  color: Colors.white,
);

const tinyText = TextStyle(
    fontFamily: 'Metropolis-Regular.otf',
    fontWeight: FontWeight.w500,
    fontSize: 14);

const tinyblack = TextStyle(
    fontFamily: 'Metropolis-Regular.otf',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.black);

import 'dart:async';

import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/models/UserData.dart';
import 'package:Lesaforrit/models/usr.dart' as usr;
import 'package:Lesaforrit/models/voices/quiz_brain_lvlOne_voice.dart';
import 'package:Lesaforrit/models/voices/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/voices/quiz_brain_lvlTwo_voice.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'quiz_brain.dart';

class SetScore extends StatelessWidget {
  String currentScore;
  String currentScoreCaps;
  String currentScoreVoice;
  String currentScoreTwo;
  String currentScoreTwoLong;
  String currentScoreTwoVoice;
  String currentScoreThree;
  String currentScoreThreeLong;
  String currentScoreThreeVoice;
  String level;
  String text;
  SetScore(
      {this.currentScore,
      this.currentScoreCaps,
      this.currentScoreVoice,
      this.currentScoreTwo,
      this.currentScoreTwoLong,
      this.currentScoreTwoVoice,
      this.currentScoreThree,
      this.currentScoreThreeLong,
      this.currentScoreThreeVoice,
      this.level,
      this.text});

  static const String id = 'SetScore';
  final _formKey = GlobalKey<FormState>();
  QuizBrain quizBrain = QuizBrain();
  QuizBrainLvlOneVoice quizBrainLvlOneVoice = QuizBrainLvlOneVoice();
  QuizBrainLvlTwoVoice quizBrainLvlTwoVoice = QuizBrainLvlTwoVoice();
  QuizBrainLvlThreeVoice quizBrainLvlThreeVoice = QuizBrainLvlThreeVoice();

  String _currentName;
  String _currentAge;
  String _currentReadingStage;

  @override
  Widget build(BuildContext context) {
    // final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);

    // updateUserData(
    //   String name,
    //   String age,
    //   String readingStage,
    //   String lvlOneScore,
    //   String lvlOneCapsScore,
    //   String lvlOneVoiceScore,
    //   String lvlTwoEasyScore,
    //   String lvlTwoMediumScore,
    //   String lvlTwoVoiceScore,
    //   String lvlThreeEasyScore,
    //   String lvlThreeMediumScore,
    //   String lvlThreeVoiceScore,
    // ) {
    //   quizBrainLvlOneCaps.reset();
    //   quizBrainLvlOne.reset();
    //   quizBrainLvlOneVoice.reset();
    //   quizBrainLvlTwoEasy.reset();
    //   quizBrainLvlTwoMedium.reset();
    //   quizBrainLvlTwoVoice.reset();
    //   quizBrainLvlThreeEasy.reset();
    //   quizBrainLvlThreeMedium.reset();
    //   quizBrainLvlThreeVoice.reset();

    //   _databaseBloc.add(UpdateUserData(
    //       name: name,
    //       age: age,
    //       readingStage: readingStage,
    //       lvlOneCapsScore: lvlOneCapsScore,
    //       lvlOneScore: lvlOneScore,
    //       lvlOneVoiceScore: lvlOneVoiceScore,
    //       lvlThreeEasyScore: lvlThreeEasyScore,
    //       lvlThreeMediumScore: lvlThreeMediumScore,
    //       lvlThreeVoiceScore: lvlThreeVoiceScore,
    //       lvlTwoEasyScore: lvlTwoEasyScore,
    //       lvlTwoMediumScore: lvlTwoMediumScore,
    //       lvlTwoVoiceScore: lvlTwoVoiceScore));
    // }

    // Usr user = Provider.of<Usr>(context);

    return (Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: RoundedButton(
                  colour: buttonColorBlue,
                  title: text,
                  onPressed: () => {
                        // updateUserData(
                        //   _currentName,
                        //   _currentAge,
                        //   _currentReadingStage,
                        //   currentScore,
                        //   currentScoreCaps,
                        //   currentScoreVoice,
                        //   currentScoreTwo,
                        //   currentScoreTwoLong,
                        //   currentScoreTwoVoice,
                        //   currentScoreThree,
                        //   currentScoreThreeLong,
                        //   currentScoreThreeVoice,
                        // ),
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            level, (Route<dynamic> route) => false)
                      }),
            )
          ],
        )));
  }
}
  





// import 'dart:async';

// import 'package:Lesaforrit/bloc/database/database_bloc.dart';
// import 'package:Lesaforrit/components/rounded_button.dart';
// import 'package:Lesaforrit/models/UserData.dart';

// import 'package:Lesaforrit/models/serverless/quiz_brain_lvlOne.dart';
// import 'package:Lesaforrit/models/serverless/quiz_brain_lvlThree_Easy.dart';
// import 'package:Lesaforrit/models/serverless/quiz_brain_lvlThree_Medium.dart';
// import 'package:Lesaforrit/models/serverless/quiz_brain_lvlTwo_Easy.dart';
// import 'package:Lesaforrit/models/serverless/quiz_brain_lvlTwo_Medium.dart';
// import 'package:Lesaforrit/models/usr.dart' as usr;
// import 'package:Lesaforrit/models/voices/quiz_brain_lvlOne_voice.dart';
// import 'package:Lesaforrit/models/voices/quiz_brain_lvlThree_voice.dart';
// import 'package:Lesaforrit/models/voices/quiz_brain_lvlTwo_voice.dart';
// import 'package:Lesaforrit/services/databaseService.dart';
// import 'package:Lesaforrit/shared/constants.dart';
// import 'package:Lesaforrit/shared/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// class SetScore extends StatelessWidget {
//   String currentScore;
//   String currentScoreCaps;
//   String currentScoreVoice;
//   String currentScoreTwo;
//   String currentScoreTwoLong;
//   String currentScoreTwoVoice;
//   String currentScoreThree;
//   String currentScoreThreeLong;
//   String currentScoreThreeVoice;
//   String level;
//   String text;
//   SetScore(
//       {this.currentScore,
//       this.currentScoreCaps,
//       this.currentScoreVoice,
//       this.currentScoreTwo,
//       this.currentScoreTwoLong,
//       this.currentScoreTwoVoice,
//       this.currentScoreThree,
//       this.currentScoreThreeLong,
//       this.currentScoreThreeVoice,
//       this.level,
//       this.text});

//   static const String id = 'SetScore';
//   final _formKey = GlobalKey<FormState>();
//   QuizBrainLvlOne quizBrainLvlOneCaps = QuizBrainLvlOne(true);
//   QuizBrainLvlOne quizBrainLvlOne = QuizBrainLvlOne(false);
//   QuizBrainLvlOneVoice quizBrainLvlOneVoice = QuizBrainLvlOneVoice();
//   QuizBrainLvlTwoEasy quizBrainLvlTwoEasy = QuizBrainLvlTwoEasy();
//   QuizBrainLvlTwoMedium quizBrainLvlTwoMedium = QuizBrainLvlTwoMedium();
//   QuizBrainLvlTwoVoice quizBrainLvlTwoVoice = QuizBrainLvlTwoVoice();
//   QuizBrainLvlThreeEasy quizBrainLvlThreeEasy = QuizBrainLvlThreeEasy();
//   QuizBrainLvlThreeMedium quizBrainLvlThreeMedium = QuizBrainLvlThreeMedium();
//   QuizBrainLvlThreeVoice quizBrainLvlThreeVoice = QuizBrainLvlThreeVoice();

//   String _currentName;
//   String _currentAge;
//   String _currentReadingStage;

//   @override
//   Widget build(BuildContext context) {
//     final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);

//     updateUserData(
//       String name,
//       String age,
//       String readingStage,
//       String lvlOneScore,
//       String lvlOneCapsScore,
//       String lvlOneVoiceScore,
//       String lvlTwoEasyScore,
//       String lvlTwoMediumScore,
//       String lvlTwoVoiceScore,
//       String lvlThreeEasyScore,
//       String lvlThreeMediumScore,
//       String lvlThreeVoiceScore,
//     ) {
//       quizBrainLvlOneCaps.reset();
//       quizBrainLvlOne.reset();
//       quizBrainLvlOneVoice.reset();
//       quizBrainLvlTwoEasy.reset();
//       quizBrainLvlTwoMedium.reset();
//       quizBrainLvlTwoVoice.reset();
//       quizBrainLvlThreeEasy.reset();
//       quizBrainLvlThreeMedium.reset();
//       quizBrainLvlThreeVoice.reset();

//       _databaseBloc.add(UpdateUserData(
//           name: name,
//           age: age,
//           readingStage: readingStage,
//           lvlOneCapsScore: lvlOneCapsScore,
//           lvlOneScore: lvlOneScore,
//           lvlOneVoiceScore: lvlOneVoiceScore,
//           lvlThreeEasyScore: lvlThreeEasyScore,
//           lvlThreeMediumScore: lvlThreeMediumScore,
//           lvlThreeVoiceScore: lvlThreeVoiceScore,
//           lvlTwoEasyScore: lvlTwoEasyScore,
//           lvlTwoMediumScore: lvlTwoMediumScore,
//           lvlTwoVoiceScore: lvlTwoVoiceScore));
//     }

//     // Usr user = Provider.of<Usr>(context);

//     return BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
//       if (state is UserScoreUpdate) {
//         return StreamController<UserData>.broadcast(
//             stream: state.userData,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 UserData userData = snapshot.data;
//                 return (Form(
//                     key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         Expanded(
//                           child: RoundedButton(
//                               colour: buttonColorBlue,
//                               title: text,
//                               onPressed: () => {
//                                     if (_formKey.currentState.validate())
//                                       {
//                                         updateUserData(
//                                             _currentName ?? userData.name,
//                                             _currentAge ?? userData.age,
//                                             _currentReadingStage ??
//                                                 userData.readingStage,
//                                             currentScore ??
//                                                 userData.lvlOneScore,
//                                             currentScoreCaps ??
//                                                 userData.lvlOneCapsScore,
//                                             currentScoreVoice ??
//                                                 userData.lvlOneVoiceScore,
//                                             currentScoreTwo ??
//                                                 userData.lvlTwoEasyScore,
//                                             currentScoreTwoLong ??
//                                                 userData.lvlTwoMediumScore,
//                                             currentScoreTwoVoice ??
//                                                 userData.lvlTwoVoiceScore,
//                                             currentScoreThree ??
//                                                 userData.lvlThreeEasyScore,
//                                             currentScoreThreeLong ??
//                                                 userData.lvlThreeMediumScore,
//                                             currentScoreThreeVoice ??
//                                                 userData.lvlThreeVoiceScore),
//                                         Navigator.of(context)
//                                             .pushNamedAndRemoveUntil(level,
//                                                 (Route<dynamic> route) => false)
//                                       }
//                                   }),
//                         )
//                       ],
//                     )));
//               }
//               return Loading();
//             });
//       }
//       return Loading();
//     });
//   }
// }




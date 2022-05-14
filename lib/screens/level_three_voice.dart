import 'dart:io';
import 'dart:typed_data';

import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/my_flutter_app_icons.dart';
import 'package:Lesaforrit/components/scorekeeper.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplateVoice.dart';
import 'package:Lesaforrit/models/voices/quiz_brain_lvlThree_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/screens/level_three_short_finish.dart';
import 'package:Lesaforrit/screens/level_three_voice_finish.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/save_audio.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:Lesaforrit/shared/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:speech_to_text/speech_to_text_provider.dart';

class LevelThreeVoice extends StatelessWidget {
  static const String id = 'level_three_short_voice';
  @override
  Widget build(BuildContext context) {
    final _speech = RepositoryProvider.of<VoiceService>(context);
    final _audioSave = RepositoryProvider.of<SaveAudio>(context);
    return BlocProvider<VoiceBloc>(
      create: (context) => VoiceBloc(_speech, 'level_3', _audioSave),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBar,
          title: Text('Raddgreining Setninga',
              style: TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 57, 53, 53))),
          iconTheme: IconThemeData(size: 36, color: Colors.black),
        ),
        endDrawer: SideMenu(),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrainLvlThreeVoice quizBrain = QuizBrainLvlThreeVoice();
  TimerWidget timer;
  TotalPoints calc = TotalPoints();
  List<Icon> scoreKeeper = []; // Empty list
  DatabaseService databaseService = DatabaseService();
  Color circleColorOne = cardColorLvlThree;
  Color circleColorTwo = cardColorLvlThree;
  int soundPress = 0;
  bool enabled = true;
  bool qEnabled = true;
  String question = '';
  String answer = '';
  bool started = false;
  double soundCircleSize = 100;
  double soundPad = 100;
  double soundPadBottom = 0;
  double soundIconSize = 50;
  String upperLetterImageCorrect = 'assets/images/star.png';
  String lowerLetterImageCorrect = 'assets/images/star.png';
  String upperLetterImage = 'assets/images/empty.png';
  String lowerLetterImage = 'assets/images/empty.png';
  String emptyImage = 'assets/images/empty.png';
  Color letterColor = Colors.black;
  Function listeningUpdate;
  SpeechToTextProvider provider;
  String lastWords = '';
  List<SpeechRecognitionAlternative> alternates = [];
  bool isListening = false;
  double points = 0;
  List<bool> questionMap = [];
  List<bool> answerMap = [];
  List<String> questionArr = [];
  List<String> answerArr = [];
  double minSoundLevel;
  double maxSoundLevel;
  double level;
  bool isShowResult = false;
  File audioFile;

  void addScore(Map<String, bool> state) {
    quizBrain.stars++;
    if (state["fivePoints"]) {
      scoreKeeper.add(Icon(
        Icons.star,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["fourPoints"]) {
      scoreKeeper.add(Icon(
        MyFlutterApp.fourpoints,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["threePoints"]) {
      scoreKeeper.add(Icon(
        MyFlutterApp.threepoints,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["twoPoints"]) {
      scoreKeeper.add(Icon(
        MyFlutterApp.twopoints,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["onePoint"]) {
      scoreKeeper.add(Icon(
        MyFlutterApp.onepoint,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else {
      print("SCOREKEEPER REMOVE");
      if (scoreKeeper.isNotEmpty) {
        scoreKeeper.removeLast();
      }
    }
    if (quizBrain.isFinished()) {
      // _voiceBloc.add(ResetEvent());
      Timer(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThreeVoiceFinish(
              stig: (calc.calculatePoints(calc.correct, calc.trys)) * 100,
            ),
          ),
        );
      });
    }
  }

  Map<String, Object> isCorrect(
      String userVoiceAnswer, String question, String lvl) {
    // if (quizBrain.isFinished() == true) {
    //   quizBrain.reset();
    // } else {

    print("question = $question");
    print("answer = $userVoiceAnswer");
    if (lvl == "level_1") {
      if (question[0].toLowerCase() == userVoiceAnswer[0].toLowerCase()) {
        userVoiceAnswer = question;
      }
    }

    int totalCorrect = 0;
    int totalIncorrect = 0;
    questionArr = question.split(' ');
    answerArr = userVoiceAnswer.split(' ');
    Map<String, int> mapQuestion = {};
    Map<String, int> mapAnswer = {};
    questionMap = [];
    answerMap = [];
    // Creating hashmap of questions
    for (var i = 0; i < questionArr.length; i++) {
      if (mapQuestion.containsKey(questionArr[i].toLowerCase())) {
        mapQuestion[questionArr[i].toLowerCase()] += 1;
      } else {
        mapQuestion[questionArr[i].toLowerCase()] = 1;
      }
    }

    // Creating hashmap of answers
    for (var i = 0; i < answerArr.length; i++) {
      if (mapAnswer.containsKey(answerArr[i].toLowerCase())) {
        mapAnswer[answerArr[i].toLowerCase()] += 1;
      } else {
        mapAnswer[answerArr[i].toLowerCase()] = 1;
      }
    }

    // Creating colorBoard for questions
    /* TODO  IF A WORD IS DUPLICATE */
    for (var i = 0; i < questionArr.length; i++) {
      if (mapAnswer.containsKey(questionArr[i].toLowerCase())) {
        questionMap.add(true);
      } else {
        questionMap.add(false);
      }
    }

    // Creating colorBoard for answers
    /* TODO  IF A WORD IS DUPLICATE */

    for (var i = 0; i < answerArr.length; i++) {
      if (mapQuestion.containsKey(answerArr[i].toLowerCase())) {
        totalCorrect += 1;
        answerMap.add(true);
      } else {
        totalIncorrect += 1;
        answerMap.add(false);
      }
    }

    // calculating points
    double points = totalCorrect / (totalCorrect + totalIncorrect);

    return {
      "points": points,
      "correct": totalCorrect,
      "questionMap": questionMap,
      "answerMap": answerMap,
      "questionArr": questionArr,
      "answerArr": answerArr
    };
    // if (userVoiceAnswer.toLowerCase() == question.toLowerCase()) {
    //   return true;
    //   // }
    // }
    // return false;
  }

  void getNewQuestion() {
    question = quizBrain.getQuestionText();
    lastWords = '';
    answer = '';
    lastWords = '';
    alternates = [];
    isListening = false;
    points = 0;
    questionMap = [];
    answerMap = [];
    questionArr = [];
    answerArr = [];
    upperLetterImage = emptyImage;
    lowerLetterImage = emptyImage;
    isShowResult = false;
  }

  dynamic bestLastWord(
      String lWords, String quest, List<SpeechRecognitionAlternative> alt) {
    print("inBestLastWordsFunction !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("$alt");
    print(lWords);
    print(quest);
    int closestVal = lWords
        .toLowerCase()
        .compareTo(quest.toLowerCase()); //compare correct answer to voice input

    int closestIndex =
        -1; //index of closest value, if -1 then result.recongizedwords
    //check if alternates are closer to correct answer
    for (int i = 0; i < alt.length; i++) {
      String tempString = alt[i].transcript.trim();
      int temp = tempString.toLowerCase().compareTo(quest.toLowerCase());
      if (temp.abs() < closestVal.abs()) {
        print("temp < closestVal");
        print("tempString: $tempString");
        print("lastWords: $lWords");
        print("tempInt: $temp");
        print("closestValInt: $closestVal");

        closestIndex = i;
        closestVal = temp;
      }
    }

    if (closestIndex == -1) {
      return lWords;
    } else {
      print("there was another");
      print(alt[closestIndex].transcript);

      lWords = alt[closestIndex].transcript;

      return lWords;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _voiceBloc = BlocProvider.of<VoiceBloc>(context);
    listeningUpdate(String lWords, List<SpeechRecognitionAlternative> alter,
        bool isList, String quest) {
      print("alternatives =============>>>>>> $alternates");
      // if (!isListening) {
      //   _voiceBloc.add(NewQuestionEvent(question: question));
      // }
      var newLWords = bestLastWord(lWords, quest, alter);
      _voiceBloc.add(UpdateEvent(
          lastWords: newLWords,
          alternates: alter,
          isListening: isList,
          question: quest));
    }

    checkAnswer(bool onePoint, bool twoPoints, bool threePoints,
        bool fourPoints, bool fivePoints,
        {String username,

        /// Correct, Incorrect, Manual_Correct, Manual_Incorrect
        String typeoffile,
        String question,
        String answer,
        Uint8List audio}) {
      _voiceBloc.add(ScoreKeeperEvent(
          onePoint: onePoint,
          twoPoints: twoPoints,
          threePoints: threePoints,
          fourPoints: fourPoints,
          fivePoints: fivePoints,
          username: 'testUserName',
          answer: lastWords,
          audio: audio,
          question: question,
          typeoffile: null));
    }

    isListeningFunc() {
      _voiceBloc.add(IsListeningEvent());
    }

    isNotListeningFunc() {
      _voiceBloc.add(IsNotListeningEvent());
    }

    void errorListener(SpeechRecognitionError error) {
      print("there was an error ${error}");
      _logEvent('Received error status: $error');
      isNotListeningFunc();
    }

    statusListener(String status) {
      print("I'm at the status listener with string $status");
      // if (status == "listening") {
      //   print("we are at the Listening status with isListening = $isListening");
      //   if (!isListening) {
      //     isListeningFunc();
      //   }
      // }
      // if (status == "notListening") {
      //   print(
      //       "we are at the not listening status with isListening = $isListening");
      //   if (isListening) {
      //     isNotListeningFunc();
      //   }
      // }
    }

    void soundLevelListener([Uint8List file]) {
      print("call is done and below are the values");

      print("lastWords is =============> $lastWords");
      print("alternates are =============> $alternates");
      // bool isFinal = result.results.map((e) => e.isFinal) as bool;

      // alternates =
      //     a.map((e) => e.isFinal ? e.alternatives.first : e.alternatives);
      // _speech.finalResult = result.finalResult;

      isListening = false;
      lastWords = bestLastWord(lastWords, question, alternates);

      Map<String, Object> score = isCorrect(lastWords, question, "level_3");
      double finalPoints = score['points'];
      points = finalPoints;

      questionMap = score['questionMap'];
      answerMap = score['answerMap'];
      questionArr = score['questionArr'];
      answerArr = score['answerArr'];

      print("resultListener finalResult");
      print("questionMap = ${questionMap}");
      print("answerMAp = ${answerMap}");
      print("questionArr = ${questionArr}");
      print("answerArr = ${answerArr}");

      // the trys are each word
      calc.trys += questionArr.length;
      calc.correct += score['correct'];

      bool onePoint = (finalPoints <= 0.2);
      bool twoPoints = (finalPoints > 0.2 && finalPoints <= 0.4);
      bool threePoints = (finalPoints > 0.4 && finalPoints <= 0.6);
      bool fourPoints = (finalPoints > 0.6 && finalPoints <= 0.8);
      bool fivePoints = (finalPoints > 0.8);

      if (fivePoints) {
        print("five Points");
      }
      if (fourPoints) {
        print("four Points");
      }
      if (threePoints) {
        print("three Points");
      }
      if (twoPoints) {
        print("Two Points");
      }
      if (onePoint) {
        print("one Points");
      }
      checkAnswer(onePoint, twoPoints, threePoints, fourPoints, fivePoints,
          username: 'testUserName',
          answer: lastWords,
          audio: file,
          question: question,
          typeoffile: null);
    }

    resultListener(StreamingRecognizeResponse result) {
      final currentText =
          result.results.map((e) => e.alternatives.first.transcript).join(' ');
      lastWords = currentText.trim();
      var alt = result.results.map((e) => e.alternatives);
      var iterator = alt.iterator;
      while (iterator.moveNext()) {
        alternates = iterator.current;
        print("alternates is $alternates");
      }
      listeningUpdate(lastWords, alternates, isListening, question);
      isListening = true;
    }

    if (!started) {
      _voiceBloc.add(VoiceInitializeEvent(
          statusListener: statusListener, errorListener: errorListener));
    }

    return Container(
      child: Scaffold(
        body: BlocListener<VoiceBloc, VoiceState>(
          listener: (context, state) {
            if (state is VoiceFailure) {
              print("VOICEBLOC STATE AFTER FAILURE ${_voiceBloc.state}");
              print("voice failure, why is this happening?");
            }
          },
          child: BlocBuilder<VoiceBloc, VoiceState>(builder: (context, state) {
            if (state is VoiceLoading) {
              print("VOICEBLOC STATE AFTER Voice Loading ${_voiceBloc.state}");
              return Loading();
            }
            if (state is VoiceHasInitialized) {
              print("state is voice initial");
              getNewQuestion();
            }
            if (state is VoiceFailure) {}
            if (state is UpdateState) {
              print("state is updatestate");
              if (state.lastWords != lastWords) {
                lastWords = state.lastWords;
                alternates = state.alternates;
              }
              if (lastWords.toLowerCase().trim() ==
                  question.toLowerCase().trim()) {
                _voiceBloc.add(VoiceStoppedEvent());
              }
            }

            if (state is ShowResultState) {
              isListening = false;
              isShowResult = true;
            }

            if (state is NewQuestionState) {
              Map<String, bool> val = {
                "onePoint": state.onePoint,
                "twoPoints": state.twoPoints,
                "threePoints": state.threePoints,
                "fourPoints": state.fourPoints,
                "fivePoints": state.fivePoints,
              };

              addScore(val);
              getNewQuestion();
            }

            if (state is IsListeningState) {
              isListening = true;
            }
            if (state is IsNotListeningState) {
              isListening = false;
            }
            if (state is VoiceStop) {
              isListening = false;
            }

            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: RecognitionResultsWidget(
                      isListening: isListening,
                      isShowResult: isShowResult,
                      questionArr: questionArr,
                      answerArr: answerArr,
                      questionMap: questionMap,
                      answerMap: answerMap,
                      onsoundLevelListener: soundLevelListener,
                      resultListener: resultListener,
                      listeningUpdate: listeningUpdate,
                      checkAnswer: checkAnswer,
                      question: question,
                      lastWords: lastWords,
                      scoreKeeper: scoreKeeper,
                      trys: calc.trys,
                      correct: calc.correct.toString(),
                      stig:
                          "STIG : ${calc.checkPoints(calc.correct, calc.trys)}",
                      cardColor: cardColor,
                      stigColor: lightBlue,
                      fontSize: 39,
                      bottomBar: BottomBar(
                          onTap: () {
                            print("tapped");
                            _voiceBloc.add(ResetEvent());
                            Navigator.pop(context);
                          },
                          image: 'assets/images/bottomBar_bl.png'),
                      shadowLevel: 30),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Theme.of(context).backgroundColor,
                  child: SpeechStatusWidget(isListening: isListening),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _logEvent(String eventDescription) {
    var eventTime = DateTime.now().toIso8601String();
    print('$eventTime $eventDescription');
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key key,
    @required this.isListening,
    @required this.isShowResult,
    @required this.questionArr,
    @required this.answerArr,
    @required this.questionMap,
    @required this.answerMap,
    @required this.onsoundLevelListener,
    @required this.resultListener,
    @required this.listeningUpdate,
    @required this.checkAnswer,
    @required this.question,
    @required this.lastWords,
    @required this.scoreKeeper,
    @required this.trys,
    @required this.correct,
    @required this.stig,
    @required this.cardColor,
    @required this.stigColor,
    @required this.fontSize,
    @required this.bottomBar,
    @required this.shadowLevel,
  }) : super(key: key);
  final bool isListening;
  final bool isShowResult;
  final List<String> questionArr;
  final List<String> answerArr;
  final List<bool> questionMap;
  final List<bool> answerMap;
  final Function onsoundLevelListener;
  final Function resultListener;
  final Function listeningUpdate;
  final Function checkAnswer;
  final String question;
  final String lastWords;
  final List<Icon> scoreKeeper;
  final int trys;
  final String correct;
  final String stig;
  final Color cardColor;
  final Color stigColor;
  final int fontSize;
  final bottomBar;
  final int shadowLevel;

  @override
  Widget build(BuildContext context) {
    return LevelTemplateVoice(
      isListening: isListening,
      isShowResult: isShowResult,
      questionArr: questionArr,
      answerArr: answerArr,
      questionMap: questionMap,
      answerMap: answerMap,
      onsoundLevelListener: onsoundLevelListener,
      resultListener: resultListener,
      listeningUpdate: listeningUpdate,
      checkAnswer: checkAnswer,
      fontSize: 39,
      cardColor: cardColorLvlThree,
      stigColor: lightBlue,
      shadowLevel: 30,
      question: question,
      lastWords: lastWords,
      scoreKeeper: scoreKeeper,
      trys: trys,
      correct: correct,
      stig: stig,
      bottomBar: bottomBar,
    );
  }
}

// /// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key key,
    @required this.isListening,
  }) : super(key: key);
  final bool isListening;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: isListening
            ? Text(
                "Að hlusta...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'Ekki að hlusta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

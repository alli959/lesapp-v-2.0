import 'dart:typed_data';

import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/my_flutter_app_icons.dart';
import 'package:Lesaforrit/components/scorekeeper.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplateVoice.dart';
import 'package:Lesaforrit/models/voices/quiz_brain_lvlTwo_voice.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/screens/level_three_short_finish.dart';
import 'package:Lesaforrit/screens/level_two_voice_finish.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:Lesaforrit/trash-geyma/letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';
import 'dart:async';
import 'dart:math';

import '../models/quiz_brain_voice.dart';
import '../services/save_audio.dart';

class LevelTwoVoice extends StatelessWidget {
  static const String id = 'level_Two_voice';
  @override
  Widget build(BuildContext context) {
    Future<bool> dialog(callback) async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: blai,
            title: Text('Handvirk Útkoma'),
            content: const Text('Las barnið rétt eða rangt?'),
            actions: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.red,
                child: TextButton(
                  child: Text('Rangt'),
                  onPressed: () {
                    callback(false);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.green,
                child: TextButton(
                  child: Text('Rétt'),
                  onPressed: () {
                    callback(true);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    final _speech = RepositoryProvider.of<VoiceService>(context);
    final _audioSave = RepositoryProvider.of<SaveAudio>(context);
    final _databaseService = RepositoryProvider.of<DatabaseService>(context);

    return BlocProvider<VoiceBloc>(
      create: (context) =>
          VoiceBloc(_speech, 'level_2', _audioSave, _databaseService, dialog),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBar,
          title: Text('Raddgreining Orða',
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
  QuizBrainVoice quizBrain = QuizBrainVoice();
  TotalPoints calc = TotalPoints();
  List<Icon> scoreKeeper = []; // Empty list
  DatabaseService databaseService = DatabaseService();
  Color circleColorOne = cardColorLvlTwo;
  Color circleColorTwo = cardColorLvlTwo;
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
  int questionTime = 5;

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
            builder: (context) => TwoVoiceFinish(
              stig: (calc.calculatePoints(calc.correct, calc.trys)) * 100,
            ),
          ),
        );
      });
    }
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

  void cancelRecord() {
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

  @override
  Widget build(BuildContext context) {
    final _voiceBloc = BlocProvider.of<VoiceBloc>(context);
    listeningUpdate(String lWords, List<SpeechRecognitionAlternative> alter,
        bool isList, String quest) {
      // if (!isListening) {
      //   _voiceBloc.add(NewQuestionEvent(question: question));
      // }
      _voiceBloc.add(UpdateEvent(
          lastWords: lWords,
          alternates: alter,
          isListening: isList,
          question: quest));
    }

    checkAnswer(bool onePoint, bool twoPoints, bool threePoints,
        bool fourPoints, bool fivePoints,
        {String username,
        String typeoffile,
        String question,
        String answer,
        Uint8List audio,
        int trys,
        int correct}) {
      if (fivePoints) {
        quizBrain.playCorrect();
      } else {
        quizBrain.playIncorrect();
      }
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
          typeoffile: fivePoints ? 'Correct' : 'Incorrect',
          trys: trys,
          correct: correct));
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
    }

    void doneListener({Uint8List file = null, bool isCancel = false}) {
      if (isCancel) {
        cancelRecord();
      } else {
        print("call is done and below are the values");

        print("lastWords is =============> $lastWords");
        print("alternates are =============> $alternates");
        // bool isFinal = result.results.map((e) => e.isFinal) as bool;

        // alternates =
        //     a.map((e) => e.isFinal ? e.alternatives.first : e.alternatives);
        // _speech.finalResult = result.finalResult;

        isListening = false;
        lastWords = quizBrain.bestLastWord(lastWords, question, alternates);

        Map<String, Object> score =
            quizBrain.isCorrect(lastWords, question, "level_3");
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
            typeoffile: null,
            trys: questionArr.length,
            correct: score['correct']);
      }
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

    // _voiceBloc.add(VoiceInitializeEvent(listeningUpdate: listeningUpdate));
    return Container(
      child: Scaffold(
        body: BlocListener<VoiceBloc, VoiceState>(
          listener: (context, state) {
            if (state is VoiceFailure) {
              print("VOICEBLOC STATE AFTER FAILURE ${_voiceBloc.state}");
            }
          },
          child: BlocBuilder<VoiceBloc, VoiceState>(builder: (context, state) {
            if (state is VoiceLoading) {
              return Loading();
            }

            if (state is VoiceHasInitialized) {
              print("state is voice initial");
              getNewQuestion();
            }

            if (state is VoiceFailure) {}
            if (state is UpdateState) {
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
            if (state is NewVoiceQuestionState) {
              Map<String, bool> val = {
                "onePoint": state.onePoint,
                "twoPoints": state.twoPoints,
                "threePoints": state.threePoints,
                "fourPoints": state.fourPoints,
                "fivePoints": state.fivePoints,
              };
              calc.trys += state.trys;
              calc.correct += state.correct;

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
                      questionTime: questionTime,
                      isListening: isListening,
                      isShowResult: isShowResult,
                      questionArr: questionArr,
                      answerArr: answerArr,
                      questionMap: questionMap,
                      answerMap: answerMap,
                      ondoneListener: doneListener,
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
                      cardColor: cardColorLvlTwo,
                      stigColor: lightGreen,
                      fontSize: 39,
                      bottomBar: BottomBar(
                          onTap: () {
                            _voiceBloc.add(ResetEvent());
                            Navigator.pop(context);
                          },
                          image: 'assets/images/bottomBar_bl.png'),
                      shadowLevel: 30),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Color.fromARGB(255, 109, 223, 112),
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
    @required this.questionTime,
    @required this.isListening,
    @required this.isShowResult,
    @required this.questionArr,
    @required this.answerArr,
    @required this.questionMap,
    @required this.answerMap,
    @required this.ondoneListener,
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
  final int questionTime;
  final bool isListening;
  final bool isShowResult;
  final List<String> questionArr;
  final List<String> answerArr;
  final List<bool> questionMap;
  final List<bool> answerMap;
  final Function ondoneListener;
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
      questionTime: questionTime,
      isListening: isListening,
      isShowResult: isShowResult,
      questionArr: questionArr,
      answerArr: answerArr,
      questionMap: questionMap,
      answerMap: answerMap,
      ondoneListener: ondoneListener,
      resultListener: resultListener,
      listeningUpdate: listeningUpdate,
      checkAnswer: checkAnswer,
      fontSize: 39,
      cardColor: cardColorLvlTwo,
      stigColor: lightGreen,
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

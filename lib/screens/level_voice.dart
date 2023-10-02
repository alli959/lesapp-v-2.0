// variables that need to be changed depending on level

//INIT config =>

// type                   level_1                      level_2                                                        level_3
// level                  "level_1"                    "level_2"                                                      "level_3"
// typeofgame             "letters"                    "words"                                                        "sentences"
// typeofdifficulty        null                        ["easy","medium"]                                              ["easy",medium]
// selecteddifficulty      "low"                       "easy"||"medium"                                               "easy"||"medium"
// difftranslate           ""                          {"easy": "Auðvellt", "medium": "Miðlungs"}                     {"easy": "Auðvellt", "medium": "Miðlungs"}
// title                   "Raddgreining Stafa"        "Raddgreining Orða ${difftranslate[$selecteddifficulty]}"      "Raddgreining Setninga ${difftranslate[$selecteddifficulty]}"
// questionTime            3                           5                                                              8
// finishwidget            OneVoiceFinish              TwoVoiceFinish                                                 ThreeVoiceFinish
// contColor               lightBlue                   Color.fromARGB(255, 109, 223, 112)                             Theme.of(context).backgroundColor
// cardColor               cardColor                   cardColorLvlTwo                                                cardColorLvlThree
// stigColor               lightCyan                   lightGreen                                                     lightBlue
// isLetter                true                        false                                                          false
import 'dart:io';
import 'dart:typed_data';

import 'package:Lesaforrit/bloc/voice/voice_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/my_flutter_app_icons.dart';
import 'package:Lesaforrit/components/sidemenu.dart';
import 'package:Lesaforrit/models/levelTemplateVoice.dart';
import 'package:Lesaforrit/models/listeners/level_voice_listener.dart';
import '../models/listeners/level_finish_listener.dart';
import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/save_audio.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:Lesaforrit/shared/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'dart:async';

import 'package:speech_to_text/speech_to_text_provider.dart';

import '../bloc/serverless/serverless_bloc.dart';
import '../components/arguments.dart';
import '../models/quiz_brain_voice.dart';
import '../services/audio_session.dart';
import '../services/get_data.dart';
import 'level_finish.dart';

class LevelVoice extends StatelessWidget {
  static const String id = 'level_voice';

  late LevelVoiceListener _levelVoiceConfig;

  late String _difficulty;
  bool haschosendifficulty = false;
  late VoiceGameType _gameType;

  LevelVoice(LevelVoiceArguments arguments) {
    this._gameType = arguments.gameType;
    switch (_gameType) {
      case VoiceGameType.letters:
        _levelVoiceConfig =
            LettersConfig(); // Set this according to your requirements);
        break;
      case VoiceGameType.words:
        _levelVoiceConfig = WordsConfig();
        break;
      case VoiceGameType.sentences:
        _levelVoiceConfig = SentencesConfig();
        break;
    }
    this._levelVoiceConfig.init();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showDifficultyDialog(callback) async {
      return _levelVoiceConfig.haschosendifficulty
          ? true
          : await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text('Veldu erfiðleikastig'),
                  content: const Text('Veldu erfiðleikastig fyrir leik'), //FIX
                  actions: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.lightGreen,
                      child: TextButton(
                        child: Text('Auðvellt',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          callback("easy");
                          _levelVoiceConfig.setDifficulty("easy");
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.blueGrey,
                      child: TextButton(
                        child: Text('Miðlungs',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          callback("medium");
                          _levelVoiceConfig.setDifficulty("medium");

                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                );
              },
            );
    }

    Future<bool> manualFixDialog(callback) async {
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
    final _audiosession = RepositoryProvider.of<AudioSessionService>(context);

    return BlocProvider<ServerlessBloc>(
        create: (context) {
          final _data = RepositoryProvider.of<GetData>(context);
          final _database = RepositoryProvider.of<DatabaseService>(context);
          var prefVoice = _database.getPreferedVoice();
          return ServerlessBloc(_data, _levelVoiceConfig.typeofgame,
              _levelVoiceConfig.selecteddifficulty)
            ..add(FetchEvent(
                prefvoice: prefVoice, difficulty: showDifficultyDialog));
        },
        child: BlocProvider<VoiceBloc>(
            create: (context) => VoiceBloc(_speech, _levelVoiceConfig.level,
                _audioSave, _databaseService, manualFixDialog),
            child: BlocBuilder<ServerlessBloc, ServerlessState>(
                builder: (context, state) {
              if (state is DifficultySet) {
                return Scaffold(body: Loading());
              }
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: appBar,
                  title: Text(_levelVoiceConfig.title,
                      style: TextStyle(
                          fontSize: _gameType.name == "letters" ? 22 : 18,
                          color: Color.fromARGB(255, 57, 53, 53))),
                  iconTheme: IconThemeData(size: 36, color: Colors.black),
                ),
                endDrawer: SideMenu(),
                body: QuizPage(
                    config: _levelVoiceConfig, audiosession: _audiosession),
              );
            })));
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key? key, required this.config, required this.audiosession})
      : super(key: key);

  LevelVoiceListener config;
  AudioSessionService audiosession;
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrainVoice quizBrain = QuizBrainVoice();
  late TimerWidget timer;
  TotalPoints calc = TotalPoints();
  List<Icon> scoreKeeper = []; // Empty list
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
  late Function listeningUpdate;
  late SpeechToTextProvider provider;
  String lastWords = '';
  List<SpeechRecognitionAlternative> alternates = [];
  bool isListening = false;
  double points = 0;
  List<bool> questionMap = [];
  List<bool> answerMap = [];
  List<String> questionArr = [];
  List<String> answerArr = [];
  late double minSoundLevel;
  late double maxSoundLevel;
  late double level;
  bool isShowResult = false;
  late File audioFile;
  int questionTime = 8;
  bool areButtonsDisabled = false;

  void addScore(Map<String, bool> state) {
    quizBrain.stars++;

    if (state["fivePoints"] == true) {
      scoreKeeper.add(Icon(
        Icons.star,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["fourPoints"] == true) {
      scoreKeeper.add(Icon(
        MyFlutterApp.fourpoints,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["threePoints"] == true) {
      scoreKeeper.add(Icon(
        MyFlutterApp.threepoints,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["twoPoints"] == true) {
      scoreKeeper.add(Icon(
        MyFlutterApp.twopoints,
        color: Colors.purpleAccent,
        size: 31,
      ));
    } else if (state["onePoint"] == true) {
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
        Navigator.of(context).pushNamedAndRemoveUntil(
            LevelFinish.id, (Route<dynamic> route) => false,
            arguments: LevelFinishArguments(widget.config.finishtype,
                calc.calculatePoints(calc.correct, calc.trys) * 100));
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
    areButtonsDisabled = false;
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

    LevelVoiceListener config = widget.config;
    void listeningUpdate(String lWords,
        List<SpeechRecognitionAlternative> alter, bool isList, String quest) {
      var newLWords = quizBrain.bestLastWord(lWords, quest, alter);
      _voiceBloc.add(UpdateEvent(
          lastWords: newLWords,
          alternates: alter,
          isListening: isList,
          question: quest));
    }

    void checkAnswer(bool onePoint, bool twoPoints, bool threePoints,
        bool fourPoints, bool fivePoints,
        {required String username,

        /// Correct, Incorrect, Manual_Correct, Manual_Incorrect
        required String typeoffile,
        required String question,
        required String answer,
        required Uint8List audio,
        required int trys,
        required int correct}) {
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
    }

    void doneListener({Uint8List? file = null, bool isCancel = false}) {
      if (isCancel || lastWords == "") {
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
            quizBrain.isCorrect(lastWords, question, config.level);
        Object? finalPoints = score['points'];
        points = finalPoints as double;

        questionMap = score['questionMap'] as List<bool>;
        answerMap = score['answerMap'] as List<bool>;
        questionArr = score['questionArr'] as List<String>;
        answerArr = score['answerArr'] as List<String>;

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
            audio: file ?? Uint8List(0),
            question: question,
            typeoffile: null ?? 'Correct',
            trys: questionArr.length,
            correct: score['correct'] as int);
      }
    }

    void resultListener(StreamingRecognizeResponse result) {
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
          statusListener: statusListener,
          errorListener: errorListener,
          audiosession: this.widget.audiosession));
    }

    return BlocBuilder<ServerlessBloc, ServerlessState>(
        builder: (context, state) {
      if (state is ServerlessLoading) {
        print("loading going on");
        return Loading();
      }
      if (state is ServerlessFetch) {
        print("state is serverlessfetch");
        if (!started) {
          quizBrain.addData(state.questionBank, widget.config.typeofgame,
              widget.config.selecteddifficulty, this.widget.audiosession);
        }
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
            child:
                BlocBuilder<VoiceBloc, VoiceState>(builder: (context, state) {
              if (state is VoiceLoading) {
                print(
                    "VOICEBLOC STATE AFTER Voice Loading ${_voiceBloc.state}");
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
                if (state.isCancel) {
                  cancelRecord();
                } else {
                  isListening = false;
                }
              }

              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: RecognitionResultsWidget(
                        questionTime: config.questionTime,
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
                        cardColor: config.cardColor,
                        stigColor: config.stigColor,
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
                    color: config.contColor,
                    child: SpeechStatusWidget(isListening: isListening),
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }

  void _logEvent(String eventDescription) {
    var eventTime = DateTime.now().toIso8601String();
    print('$eventTime $eventDescription');
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.questionTime,
    required this.isListening,
    required this.isShowResult,
    required this.questionArr,
    required this.answerArr,
    required this.questionMap,
    required this.answerMap,
    required this.ondoneListener,
    required this.resultListener,
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
  }) : super(key: key);
  final int questionTime;
  final bool isListening;
  final bool isShowResult;
  final List<String> questionArr;
  final List<String> answerArr;
  final List<bool> questionMap;
  final List<bool> answerMap;
  final void Function() ondoneListener;
  final void Function(StreamingRecognizeResponse) resultListener;
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
      cardColor: cardColor,
      stigColor: stigColor,
      shadowLevel: 30,
      question: question,
      lastWords: lastWords,
      scoreKeeper: scoreKeeper,
      trys: trys,
      correct: correct,
      stig: stig,
      bottomBar: bottomBar,
      isLetters: false,
    );
  }
}

// /// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key? key,
    required this.isListening,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            : Text(
                'Ekki að hlusta, ýttu á hljóðnema',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
      ),
    );
  }
}

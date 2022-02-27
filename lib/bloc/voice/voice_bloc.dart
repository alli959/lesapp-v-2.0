import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

part 'voice_event.dart';
part 'voice_state.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  // final SpeechToText _speech;
  final VoiceService _speech;
  final String level;

  VoiceBloc(VoiceService speech, String level)
      : _speech = speech,
        level = level,
        super(VoiceInitial(
          hasSpeech: false,
          logEvents: false,
          isListening: false,
          level: 0.0,
          minSoundLevel: 50000,
          maxSoundLevel: -50000,
          lastWords: ' ',
          lastError: ' ',
          lastStatus: ' ',
          currentLocaleId: 'is_IS',
          localeNames: [],
        ));

  @override
  Stream<VoiceState> mapEventToState(VoiceEvent event) async* {
    if (event is VoiceInitializeEvent) {
      yield* _mapUpdateInitalizeToState(event);
    }

    if (event is VoiceFailureEvent) {
      yield* _mapVoiceFailure(event);
    }

    if (event is VoiceStartedEvent) {
      yield* _mapVoiceStartedEvent(event);
    }

    if (event is NewQuestionEvent) {
      yield* _mapNewQuestionEvent(event);
    }

    if (event is UpdateEvent) {
      yield* _mapLastWordsEvent(event);
    }

    if (event is SoundLevelEvent) {
      yield* _mapSoundLevelEvent(event);
    }

    if (event is VoiceStoppedEvent) {
      yield* _mapVoiceStopEvent(event);
    }
    if (event is FindBestLastWordEvent) {
      yield* _mapFindBestLastWordEvent(event);
    }

    if (event is ScoreKeeperEvent) {
      yield* _mapScoreKeeperToState(event);
    }
  }

  Stream<VoiceState> _mapUpdateInitalizeToState(
      VoiceInitializeEvent event) async* {
    yield VoiceLoading();
    print("lastWords in status ${_speech.lastWords}");
    _logEvent('Initialize');
    String lastWords = '';
    List<SpeechRecognitionWords> alternates = [];
    bool isListening = false;
    String question = _speech.displayText(level);
    _speech.question = question;

    statusListener(String status) {
      _logEvent(
          'Received listener status: $status, listening: ${_speech.speech.isListening}');
      print("I'm at the status listener");
      // event.listeningUpdate(_speech.lastWords, _speech.alternates,
      //     _speech.speech.isListening, _speech.question);
    }

    onError(String test) {
      print("there was an error");
      event.listeningUpdate(' ', alternates, false, _speech.question);
    }

    try {
      // initialize the speech
      var hasSpeech = await _speech.speechInit(statusListener);
      if (hasSpeech) {
        yield VoiceHasInitialized(hasSpeech: hasSpeech);
        //initiallize language
        yield UpdateState(
            lastWords: lastWords,
            alternates: alternates,
            isListening: isListening,
            question: _speech.question);
        yield VoiceLanguage(currentLocaleId: 'is_IS');
      }
      print("was there a speech?");
    } catch (e) {
      yield VoiceFailure(error: e);
    }

    yield UpdateState(
        lastWords: _speech.lastWords,
        alternates: _speech.alternates,
        isListening: _speech.speech.isListening,
        question: _speech.question);
  }

  Stream<VoiceState> _mapVoiceFailure(VoiceFailureEvent event) async* {
    print("THERE WAS AN FAILURE");
    yield VoiceFailure(error: event.error);
  }

  Stream<VoiceState> _mapVoiceStartedEvent(VoiceStartedEvent event) async* {
    _logEvent('start listening');
    // _speech.lastWords = ' ';
    _speech.alternates = [];
    _speech.isListening = true;

    // String lastWords = '';
    // List<SpeechRecognitionWords> alternates = [];
    // bool isListening = false;

    yield UpdateState(
        lastWords: ' ',
        alternates: _speech.alternates,
        isListening: true,
        question: _speech.question);

    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    resultListener(SpeechRecognitionResult result) {
      print("lastWords in result ${_speech.lastWords}");
      _logEvent(
          'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
      _speech.lastWords = '${result.recognizedWords}';
      _speech.alternates = result.alternates;
      // _speech.finalResult = result.finalResult;
      _speech.isListening = _speech.speech.isListening;

      if (!_speech.isListening) {
        _speech.lastWords = _speech.bestLastWord(
            _speech.lastWords, _speech.question, _speech.alternates);

        Map<String, Object> points =
            _speech.checkAnswer(_speech.lastWords, _speech.question);
        double finalPoints = points['points'];
        _speech.points = finalPoints;
        _speech.questionMap = points['questionMap'];
        _speech.answerMap = points['answerMap'];
        _speech.questionArr = points['questionArr'];
        _speech.answerArr = points['answerArr'];

        print("answerMAp = ${_speech.answerMap}");

        // the trys are each word
        _speech.calc.trys += _speech.questionArr.length;
        _speech.calc.correct += points['correct'];

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

        event.checkAnswer(onePoint, twoPoints, threePoints, fourPoints,
            fivePoints, _speech.calc);
      } else {
        event.listeningUpdate(_speech.lastWords, _speech.alternates,
            _speech.isListening, _speech.question);
      }
    }

    try {
      _speech.speechListen(resultListener);
    } catch (err) {
      print("error = ${err}");

      yield VoiceFailure(error: err);
    }
    // yield NewQuestionState(question: _speech.question);
  }

  Stream<VoiceState> _mapNewQuestionEvent(NewQuestionEvent event) async* {
    String question = _speech.displayText(level);
    _speech.question = question;
    yield NewQuestionState(question: question);
  }

  Stream<VoiceState> _mapLastWordsEvent(UpdateEvent event) async* {
    yield UpdateState(
        lastWords: event.lastWords,
        alternates: event.alternates,
        isListening: event.isListening,
        question: event.question);
  }

  Stream<VoiceState> _mapSoundLevelEvent(SoundLevelEvent event) async* {
    yield SoundLevelState(level: event.level);
  }

  Stream<VoiceState> _mapVoiceStopEvent(VoiceStoppedEvent event) async* {
    yield VoiceStop();
  }

  Stream<VoiceState> _mapScoreKeeperToState(ScoreKeeperEvent event) async* {
    yield ScoreKeeper(
        onePoint: event.onePoint,
        twoPoints: event.twoPoints,
        threePoints: event.threePoints,
        fourPoints: event.fourPoints,
        fivePoints: event.fivePoints,
        calc: event.calc);
    await Future.delayed(Duration(milliseconds: 200));
    String question = _speech.displayText(level);
    _speech.nextQuestion = question;

    // Getting the results ready
    List<String> questionArr = _speech.questionArr;
    List<String> answerArr = _speech.answerArr;
    List<bool> questionMap = _speech.questionMap;
    List<bool> answerMap = _speech.answerMap;

    print("THIS IS THE QUESTIONARR ${questionArr}");
    yield ShowResultState(
        questionArr: questionArr,
        answerArr: answerArr,
        questionMap: questionMap,
        answerMap: answerMap);
    await Future.delayed(Duration(milliseconds: 3000));

    _speech.question = _speech.nextQuestion;
    _speech.questionMap = [];
    _speech.answerMap = [];
    _speech.questionArr = [];
    _speech.answerArr = [];
    yield NewQuestionState(question: _speech.question);
  }

  Stream<VoiceState> _mapFindBestLastWordEvent(
      FindBestLastWordEvent event) async* {
    String lastWords = event.lastWords;
    List<SpeechRecognitionWords> alternates = event.alternates;
    String question = event.question;

    // int closestVal = lastWords.toLowerCase().compareTo(
    //     letter.toLowerCase()); //compare correct answer to voice input

    // int closestIndex =
    //     -1; //index of closest value, if -1 then result.recongizedwords
    // if (status == 'done') {
    //   //check if alternates are closer to correct answer
    //   for (int i = 0; i < alternates.length; i++) {
    //     String tempString = alternates[i].recognizedWords;
    //     int temp = tempString.toLowerCase().compareTo(letter.toLowerCase());
    //     if (temp.abs() < closestVal.abs()) {
    //       print("temp < closestVal");
    //       print("tempString: $tempString");
    //       print("lastWords: $lastWords");
    //       print("tempInt: $temp");
    //       print("closestValInt: $closestVal");

    //       closestIndex = i;
    //       closestVal = temp;
    //     }
    //   }
    //   if (closestIndex == -1) {
    //     checkAnswer(lastWords);
    //   } else {
    //     print("there was another");
    //     print(alternates[closestIndex].recognizedWords);

    //     setState(() {
    //       lastWords = alternates[closestIndex].recognizedWords;
    //     });

    //     checkAnswer(alternates[closestIndex].recognizedWords);
    //   }
    // }
  }

  /* Helper functions */

  // void errorListener(SpeechRecognitionError error) {
  //   _logEvent(
  //       'Received error status: $error, listening: ${_speech.isListening}');
  //   VoiceFailureEvent(error: '${error.errorMsg} - ${error.permanent}');
  // }

  // void resultListener(SpeechRecognitionResult result) {
  //   print("result alt");
  //   print(result.alternates);
  //   _logEvent(
  //       'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
  //   WordsChange(
  //       lastWords: '${result.recognizedWords}', alternates: result.alternates);
  //   // LastWordsEvent(
  //   //     lastWords: '${result.recognizedWords}', alternates: result.alternates);
  // }

  // void soundLevelListener(double level) {
  //   print("soundLevelListener stuff");
  //   SoundLevelEvent(level: level);
  // }

  // void statusListener(String status) {
  //   _logEvent(
  //       'Received listener status: $status, listening: ${_speech.isListening}');
  //   VoiceStatusEvent(lastStatus: status);
  //   // int closestVal = lastWords.toLowerCase().compareTo(
  //   //     letter.toLowerCase()); //compare correct answer to voice input

  //   // int closestIndex =
  //   //     -1; //index of closest value, if -1 then result.recongizedwords
  //   // if (status == 'done') {
  //   //   //check if alternates are closer to correct answer
  //   //   for (int i = 0; i < alternates.length; i++) {
  //   //     String tempString = alternates[i].recognizedWords;
  //   //     int temp = tempString.toLowerCase().compareTo(letter.toLowerCase());
  //   //     if (temp.abs() < closestVal.abs()) {
  //   //       print("temp < closestVal");
  //   //       print("tempString: $tempString");
  //   //       print("lastWords: $lastWords");
  //   //       print("tempInt: $temp");
  //   //       print("closestValInt: $closestVal");

  //   //       closestIndex = i;
  //   //       closestVal = temp;
  //   //     }
  //   //   }
  //   //   if (closestIndex == -1) {
  //   //     checkAnswer(lastWords);
  //   //   } else {
  //   //     print("there was another");
  //   //     print(alternates[closestIndex].recognizedWords);

  //   //     setState(() {
  //   //       lastWords = alternates[closestIndex].recognizedWords;
  //   //     });

  //   //     checkAnswer(alternates[closestIndex].recognizedWords);
  //   //   }
  //   // }
  // }

  void _logEvent(String eventDescription) {
    var eventTime = DateTime.now().toIso8601String();
    print('$eventTime $eventDescription');
  }
}

import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

part 'voice_event.dart';
part 'voice_state.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  // final SpeechToText _speech;
  final VoiceService _speech;

  VoiceBloc(VoiceService speech)
      : _speech = speech,
        super(VoiceInitial(
          hasSpeech: false,
          logEvents: false,
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

    if (event is LastWordsEvent) {
      yield* _mapLastWordsEvent(event);
    }

    if (event is SoundLevelEvent) {
      yield* _mapSoundLevelEvent(event);
    }

    if (event is VoiceStatusEvent) {
      yield* _mapVoiceStatusToState(event);
    }

    if (event is VoiceStoppedEvent) {
      yield* _mapVoiceStopEvent(event);
    }

    if (event is isListeningEvent) {
      yield* _mapVoiceIsListeningEvent(event);
    }

    // if (event is VoiceStartedEvent) {
    //   yield* _mapVoiceStartedToState(event);
    // }
  }

  Stream<VoiceState> _mapUpdateInitalizeToState(
      VoiceInitializeEvent event) async* {
    yield VoiceLoading();
    _logEvent('Initialize');

    statusListener(String status) {
      _logEvent(
          'Received listener status: $status, listening: ${_speech.speech.isListening}');
      _speech.lastStatus = _speech.speech.lastStatus;
    }

    try {
      // initialize the speech
      var hasSpeech = await _speech.speechInit(statusListener);
      if (hasSpeech) {
        yield VoiceHasInitialized(hasSpeech: hasSpeech);
        //initiallize language
        yield VoiceLanguage(currentLocaleId: 'is_IS');
      }
    } catch (e) {
      yield VoiceFailure(error: e);
    }
  }

  Stream<VoiceState> _mapVoiceFailure(VoiceFailureEvent event) async* {
    yield VoiceFailure(error: event.error);
  }

  Stream<VoiceState> _mapVoiceStartedEvent(VoiceStartedEvent event) async* {
    yield VoiceLoading();
    _logEvent('start listening');
    String lastWords = '';
    List<SpeechRecognitionWords> alternates = [];
    yield WordsChange(lastWords: lastWords, alternates: alternates);
    // yield WordsChange(lastWords: '');

    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    resultListener(SpeechRecognitionResult result) {
      _logEvent(
          'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
      _speech.lastWords = '${result.recognizedWords}';
      _speech.alternates = result.alternates;
      _speech.finalResult = result.finalResult;
      bool isListening = _speech.speech.isListening;
      event.callback(_speech.lastWords, isListening);
    }

    _speech.speechListen(resultListener);
  }

  Stream<VoiceState> _mapVoiceStatusToState(VoiceStatusEvent event) async* {
    yield VoiceStatusState(lastStatus: event.lastStatus);
  }

  Stream<VoiceState> _mapLastWordsEvent(LastWordsEvent event) async* {
    yield WordsChange(lastWords: event.lastWords, alternates: event.alternates);
  }

  Stream<VoiceState> _mapSoundLevelEvent(SoundLevelEvent event) async* {
    yield SoundLevelState(level: event.level);
  }

  Stream<VoiceState> _mapVoiceStopEvent(VoiceStoppedEvent event) async* {
    yield VoiceStop();
  }

  Stream<VoiceState> _mapVoiceIsListeningEvent(isListeningEvent event) async* {
    yield IsListeningState(isListening: event.isListening);
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

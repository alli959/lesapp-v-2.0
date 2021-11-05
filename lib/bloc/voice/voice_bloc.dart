import 'dart:math';

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
  final SpeechToText _speech;

  VoiceBloc(SpeechToText speech)
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

    // if (event is VoiceStartedEvent) {
    //   yield* _mapVoiceStartedToState(event);
    // }
  }

  Stream<VoiceState> _mapUpdateInitalizeToState(
      VoiceInitializeEvent event) async* {
    yield VoiceLoading();
    _logEvent('Initialize');

    try {
      print(_speech);
      // initialize the speech
      var hasSpeech = await _speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0),
      );
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
    print("AT ERROR EVENT");
    yield VoiceFailure(error: event.error);
  }

  Stream<VoiceState> _mapVoiceStartedEvent(VoiceStartedEvent event) async* {
    _logEvent('start listening');
    yield WordsChange(lastWords: '');
    print("WE ARE HERE!!!!");

    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    print(_speech);
    _speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 10),
        partialResults: true,
        localeId: 'is_IS',
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);

    print("after starting speech");
  }

  Stream<VoiceState> _mapVoiceStatusToState(VoiceStatusEvent event) async* {
    print("AT VOICE STATUS EVENT");
    yield VoiceStatusState(lastStatus: event.lastStatus);
  }

  Stream<VoiceState> _mapLastWordsEvent(LastWordsEvent event) async* {
    print("AT VOICE LAST WORDS EVENT");
    yield WordsChange(lastWords: event.lastWords, alternates: event.alternates);
  }

  Stream<VoiceState> _mapSoundLevelEvent(SoundLevelEvent event) async* {
    print("AT SOUND LEVEL EVENT");
    yield SoundLevelState(level: event.level);
  }

  /* Helper functions */

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${_speech.isListening}');
    VoiceFailureEvent(error: '${error.errorMsg} - ${error.permanent}');
  }

  void resultListener(SpeechRecognitionResult result) {
    print("result alt");
    print(result.alternates);
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    LastWordsEvent(
        lastWords: '${result.recognizedWords}', alternates: result.alternates);
  }

  void soundLevelListener(double level) {
    print("soundLevelListener stuff");
    SoundLevelEvent(level: level);
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${_speech.isListening}');
    VoiceStatusEvent(lastStatus: status);
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

  void _logEvent(String eventDescription) {
    var eventTime = DateTime.now().toIso8601String();
    print('$eventTime $eventDescription');
  }
}

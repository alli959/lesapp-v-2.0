import 'dart:io';
import 'dart:typed_data';

import 'package:Lesaforrit/models/total_points.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/services/save_audio.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart';

part 'voice_event.dart';
part 'voice_state.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  // final SpeechToText _speech;
  final VoiceService _speech;
  final String level;
  final SaveAudio audioSaver;

  VoiceBloc(VoiceService speech, String level, SaveAudio audioSaver)
      : _speech = speech,
        level = level,
        audioSaver = audioSaver,
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

    if (event is ResetEvent) {
      yield* _mapResetEventToState(event);
    }
    if (event is IsListeningEvent) {
      yield* _mapListeningoState(event);
    }

    if (event is IsNotListeningEvent) {
      yield* _mapNotListeningoState(event);
    }
  }

  Stream<VoiceState> _mapUpdateInitalizeToState(
      VoiceInitializeEvent event) async* {
    yield VoiceLoading();
    try {
      // initialize the speech
      var hasSpeech =
          await _speech.speechInit(event.statusListener, event.errorListener);
      if (hasSpeech) {
        print("it has speech");
        yield VoiceHasInitialized();
      }
    } catch (e) {
      print("error initializing speech");
      yield VoiceFailure(error: e);
    }
  }

  Stream<VoiceState> _mapVoiceFailure(VoiceFailureEvent event) async* {
    print("THERE WAS AN FAILURE");
    yield VoiceFailure(error: event.error);
  }

  Stream<VoiceState> _mapVoiceStartedEvent(VoiceStartedEvent event) async* {
    try {
      await _speech.speechListen(
          event.resultListener, event.soundLevelListener);
      yield IsListeningState();
    } catch (err) {
      print("error = $err");
      await _speech.stopRecording();
      yield VoiceFailure(error: err);
    }
    // yield NewQuestionState(question: _speech.question);
  }

  Stream<VoiceState> _mapNewQuestionEvent(NewQuestionEvent event) async* {
    yield NewQuestionState();
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
    await _speech.stopRecording();
    yield VoiceStop();
  }

  Stream<VoiceState> _mapScoreKeeperToState(ScoreKeeperEvent event) async* {
    // Getting the results ready
    yield IsNotListeningState();
    yield ShowResultState();
    await Future.delayed(Duration(milliseconds: 3000));

    if (event.answer != null) {
      if (event.fivePoints) {
        audioSaver.setData(
            'testName', 'Correct', event.question, event.answer, event.audio);
      } else {
        audioSaver.setData(
            'testName', 'Incorrect', event.question, event.answer, event.audio);
      }

      try {
        await audioSaver.saveData();
      } catch (err) {
        print("there was an error saving data from bloc => $err");
      }
    }

    yield NewQuestionState(
        onePoint: event.onePoint,
        twoPoints: event.twoPoints,
        threePoints: event.threePoints,
        fourPoints: event.fourPoints,
        fivePoints: event.fivePoints);
  }

  Stream<VoiceState> _mapFindBestLastWordEvent(
      FindBestLastWordEvent event) async* {
    String lastWords = event.lastWords;
    List<SpeechRecognitionWords> alternates = event.alternates;
    String question = event.question;
  }

  Stream<VoiceState> _mapResetEventToState(ResetEvent event) async* {
    yield VoiceLoading();
    _speech.reset();
    yield ResetState();
  }

  Stream<VoiceState> _mapListeningoState(IsListeningEvent event) async* {
    yield IsListeningState();
  }

  Stream<VoiceState> _mapNotListeningoState(IsNotListeningEvent event) async* {
    yield IsNotListeningState();
  }

  void _logEvent(String eventDescription) {
    var eventTime = DateTime.now().toIso8601String();
    print('$eventTime $eventDescription');
  }
}

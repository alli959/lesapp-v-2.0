import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/models/usr.dart' as usr;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:provider/provider.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import 'package:just_audio/just_audio.dart' as ja;

import '../models/ModelProvider.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class AudioSessionService {
  String uid;
  final _player = ja.AudioPlayer(
    handleInterruptions: false,
    androidApplyAudioAttributes: false,
    handleAudioSessionActivation: false,
  );
  RecorderStream _recorder = RecorderStream();
  PlayerStream _playerStream = PlayerStream();
  AudioSessionService({this.uid});

  Future init() async {
    AudioSession.instance.then((audioSession) async {
      // This line configures the app's audio session, indicating to the OS the
      // type of audio we intend to play. Using the "speech" recipe rather than
      // "music" since we are playing a podcast.
      await audioSession.configure(AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy:
            AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ));
      // Listen to audio interruptions and pause or duck as appropriate.
      _handleInterruptions(audioSession);
      // Use another plugin to load audio to play

      // await _recorder.initialize();
      // await _playerStream.initialize();
    });
  }

  Future startRecording() async {
    await _recorder.start();
  }

  Future setPlayerUrl(String url) async {
    _player.setUrl(url);
  }

  Future setPlayerLocalUrl(String url, [int startPosInMiliSec = 0]) async {
    await _player.setAsset(url,
        initialPosition: Duration(milliseconds: startPosInMiliSec));
  }

  void play() {
    _player.play();
  }

  void _handleInterruptions(AudioSession audioSession) {
    print('WE ARE AT THE HANDLE INTERRUPTIONS GUY');
    // just_audio can handle interruptions for us, but we have disabled that in
    // order to demonstrate manual configuration.
    bool playInterrupted = false;
    audioSession.becomingNoisyEventStream.listen((_) {
      print('PAUSE');
      _player.pause();
    });
    _player.playingStream.listen((playing) {
      print('playing!!!!!!!!!!!!!!!!!!!!!!!!!!!!: $playing');
      playInterrupted = false;
      if (playing) {
        audioSession.setActive(true);
      }
    });
    audioSession.interruptionEventStream.listen((event) {
      print('interruption begin: ${event.begin}');
      print('interruption type: ${event.type}');
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            if (audioSession.androidAudioAttributes.usage ==
                AndroidAudioUsage.game) {
              print('Ducking not supported for game audio');
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            if (_player.playing) {
              _player.pause();
              playInterrupted = true;
            }
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(min(1.0, _player.volume * 2));
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) _player.play();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            playInterrupted = false;
            break;
        }
      }
    });
    audioSession.devicesChangedEventStream.listen((event) {
      print('Devices added: ${event.devicesAdded}');
      print('Devices removed: ${event.devicesRemoved}');
    });
  }
}

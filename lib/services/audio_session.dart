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
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import 'package:just_audio/just_audio.dart' as ja;
import 'package:rxdart/rxdart.dart';
import 'package:google_speech/google_speech.dart';

import '../models/ModelProvider.dart';

// Feed your own stream of bytes into the player
class MyCustomSource extends ja.StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<ja.StreamAudioResponse> request([int start, int end]) async {
    start ??= 0;
    end ??= bytes.length;
    return ja.StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/x-wav',
    );
  }
}

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class AudioSessionService {
  String uid;
  ja.AudioPlayer _player = ja.AudioPlayer(
    handleInterruptions: false,
    androidApplyAudioAttributes: false,
    handleAudioSessionActivation: false,
  );
  RecorderStream _recorder = RecorderStream();
  PlayerStream _playerStream = PlayerStream();
  AudioSessionService({this.uid});
  StreamSubscription<List<int>> _audioStreamSubscription;
  BehaviorSubject<List<int>> _audioStream;
  List<Uint8List> audioList = [];
  bool recognizing = false;
  bool isCancel = false;
  bool isSave = true;
  AudioSession _audioSession;

  Uint8List saveFile(List<Uint8List> contents, sampleRate) {
    // File recordedFile = File(await getFilePath());
    print("at savefile place");
    print("contents are $contents");
    // first stop recording
    List<int> data = [];
    for (var i = 0; i < contents.length; i++) {
      print("i is $i");
      try {
        data.addAll(contents[i]);
      } catch (err) {
        print("there was an error $err");
        throw err;
      }
    }

    var channels = 1;

    int byteRate = ((16 * sampleRate * channels) / 8).round();

    var size = data.length;

    var fileSize = size + 36;

    Uint8List header = Uint8List.fromList([
      // "RIFF"
      82, 73, 70, 70,
      fileSize & 0xff,
      (fileSize >> 8) & 0xff,
      (fileSize >> 16) & 0xff,
      (fileSize >> 24) & 0xff,
      // WAVE
      87, 65, 86, 69,
      // fmt
      102, 109, 116, 32,
      // fmt chunk size 16
      16, 0, 0, 0,
      // Type of format
      1, 0,
      // One channel
      channels, 0,
      // Sample rate
      sampleRate & 0xff,
      (sampleRate >> 8) & 0xff,
      (sampleRate >> 16) & 0xff,
      (sampleRate >> 24) & 0xff,
      // Byte rate
      byteRate & 0xff,
      (byteRate >> 8) & 0xff,
      (byteRate >> 16) & 0xff,
      (byteRate >> 24) & 0xff,
      // Uhm
      ((16 * channels) / 8).round(), 0,
      // bitsize
      16, 0,
      // "data"
      100, 97, 116, 97,
      size & 0xff,
      (size >> 8) & 0xff,
      (size >> 16) & 0xff,
      (size >> 24) & 0xff,
      ...data
    ]);

    // File deployFile = new File.fromRawPath(header);
    audioList = [];
    // await recordedFile.writeAsBytes(header, flush: true);

    return header;
  }

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

      await _recorder.initialize();
      await _playerStream.initialize();
      this._audioSession = audioSession;
      // Listen to audio interruptions and pause or duck as appropriate.
      _handleInterruptions(this._audioSession);

      // Use another plugin to load audio to play
    });
  }

  Future stopRecording(bool isCancelparams, bool isSaveParams) async {
    this.isCancel = isCancelparams;
    this.isSave = isSaveParams;
    if (isCancel || !isSave) {
      audioList = [];
    }
    await _recorder?.stop();
    await _playerStream?.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    recognizing = false;
    _player = ja.AudioPlayer(
      handleInterruptions: false,
      androidApplyAudioAttributes: false,
      handleAudioSessionActivation: false,
    );
  }

  Future startRecording(resultListener, Function doneListener,
      RecognitionConfig config, SpeechToText speech) async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      if (!_audioStream.isClosed) {
        _audioStream.add(event);
        audioList.add(event);
        _playerStream.writeChunk(event);
      } else {
        print("audiostream is closed!!!!");
      }
    });
    print("at start recording place");
    try {
      await _recorder.start();
    } catch (err) {
      print("there was an error $err");
      return false;
    }
    recognizing = true;
    final responseStream = speech.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream);
    try {
      if (!_audioStream.isClosed) {
        responseStream.listen(resultListener,
            onDone: () => doneListener(
                file: saveFile(audioList, 16000), isCancel: isCancel));
      } else {
        print("audio stream is closed in startRecording method");
      }
    } catch (err) {
      print("there was an error $err");
      return false;
    }
    this.isCancel = false;
  }

  Future setPlayerUrl(String url) async {
    print("at set online player place");
    try {
      await _player.setUrl(url);
    } catch (err) {
      print("there was an error setting online player url");
      print(err);
    }
  }

  Future setPlayerLocalUrl(String url, [int startPosInMiliSec = 0]) async {
    print("at Set local url place");
    try {
      await _player.setAsset(url,
          initialPosition: Duration(milliseconds: startPosInMiliSec));
    } catch (err) {
      print("there was an error setting local url");
      print(err);
    }
  }

  Future play() async {
    print("player is going to play");
    try {
      await _player.play();
    } catch (err) {
      print("there was an error playing sound");
      print(err);
    }
  }

  Future _handleInterruptions(AudioSession audioSession) async {
    if (await audioSession.setActive(true)) {
      bool playInterrupted = false;
      audioSession.becomingNoisyEventStream.listen((_) {
        print('PAUSE');
        _player.pause();
      });
      _player.playingStream.listen((playing) {
        playInterrupted = false;
        if (playing) {
          audioSession.setActive(true);
        }
      });
      // _audioStream = BehaviorSubject<List<int>>();
      // _audioStreamSubscription = _recorder.audioStream.listen((event) {
      //   if (!_audioStream.isClosed) {
      //     _audioStream.add(event);
      //     audioList.add(event);
      //     _playerStream.writeChunk(event);
      //   } else {
      //     print("audiostream is closed!!!!");
      //   }
      // });

      audioSession.getDevices().then((value) {
        print("devices: $value");
      });

      audioSession.interruptionEventStream.listen((event) {
        print('interruption begin: ${event.begin}');
        print('interruption type: ${event.type}');
        if (event.begin) {
          switch (event.type) {
            case AudioInterruptionType.duck:
              print("AUDIO INTERUPTION DUCK UPPER");
              if (audioSession.androidAudioAttributes.usage ==
                  AndroidAudioUsage.game) {
                print('Ducking not supported for game audio');
              }
              playInterrupted = false;
              break;
            case AudioInterruptionType.pause:
              print("AUDIO INTERUPTION PAUSE UPPER");
              break;
            case AudioInterruptionType.unknown:
              print("AUDIO INTERUPTION UNKNOWN UPPER");
              if (_player.playing) {
                _player.pause();
                playInterrupted = true;
              }
              break;
          }
        } else {
          switch (event.type) {
            case AudioInterruptionType.duck:
              print("AUDIO INTERUPTION DUCK LOWER");
              _player.setVolume(min(1.0, _player.volume * 2));
              playInterrupted = false;
              break;
            case AudioInterruptionType.pause:
              print("AUDIO INTERUPTION PAUSE LOWER");
              if (playInterrupted) _player.play();
              playInterrupted = false;
              break;
            case AudioInterruptionType.unknown:
              print("AUDIO INTERUPTION UNKNOWN LOWER");
              playInterrupted = false;
              break;
          }
        }
      });
      audioSession.devicesChangedEventStream.listen((event) {
        print('Devices added: ${event.devicesAdded}');
        print('Devices removed: ${event.devicesRemoved}');
      });
    } else {
      print('Failed to activate audio session');
    }
  }
}

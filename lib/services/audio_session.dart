import 'dart:async';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart' hide AVAudioSessionCategory;
import 'package:flutter/foundation.dart';
import 'package:google_speech/google_speech.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class MyCustomSource extends ja.StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<ja.StreamAudioResponse> request([int? start, int? end]) async {
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
  ja.AudioPlayer _player;
  RecorderStream _recorder;
  PlayerStream _playerStream;
  late StreamSubscription<List<int>> _audioStreamSubscription;
  late BehaviorSubject<List<int>> _audioStream;
  List<Uint8List> audioList = [];
  bool recognizing = false;
  bool isCancel = false;
  bool isSave = true;
  late AudioSession _audioSession;

  AudioSessionService({required this.uid})
      : _player = ja.AudioPlayer(
          handleInterruptions: false,
          androidApplyAudioAttributes: false,
          handleAudioSessionActivation: false,
        ),
        _recorder = RecorderStream(),
        _playerStream = PlayerStream();

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
    await _configureAudioSession();
    await _recorder.initialize();
    await _playerStream.initialize();
    _handleInterruptions(_audioSession);
  }

  Future _configureAudioSession() async {
    _audioSession = await AudioSession.instance;
    await _audioSession.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      /**The name 'AVAudioSessionCategory' is defined in the libraries 'package:audio_session/src/darwin.dart (via package:audio_session/audio_session.dart)' and 'package:audioplayers_platform_interface/src/api/audio_context.dart (via package:audioplayers/audioplayers.dart)'.
Try using 'as prefix' for one of the import directives, or hiding the name from all but one of the imports.dartambiguous_import */
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
  }

  // Recording
  Future startRecording(resultListener, Function doneListener,
      RecognitionConfig config, SpeechToText speech) async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      if (!_audioStream.isClosed) {
        _audioStream.add(event);
        audioList.add(event);
        _playerStream.writeChunk(event);
      }
    });

    await _recorder.start();
    recognizing = true;

    final responseStream = speech.streamingRecognize(
      StreamingRecognitionConfig(config: config, interimResults: true),
      _audioStream,
    );

    responseStream.listen(resultListener,
        onDone: () =>
            doneListener(file: saveFile(audioList, 16000), isCancel: isCancel));
    this.isCancel = false;
  }

  Future stopRecording(bool isCancelparams, bool isSaveParams) async {
    this.isCancel = isCancelparams;
    this.isSave = isSaveParams;
    if (isCancel || !isSave) {
      audioList = [];
    }
    await _recorder.stop();
    await _playerStream.stop();
    await _audioStreamSubscription.cancel();
    await _audioStream.close();
    recognizing = false;
    _player = ja.AudioPlayer(
      handleInterruptions: false,
      androidApplyAudioAttributes: false,
      handleAudioSessionActivation: false,
    );
  }

  // Playback
  Future setPlayerUrl(String url) async {
    await _player.setUrl(url);
    _player.setVolume(100.0);
  }

  Future setPlayerLocalUrl(String url, [int startPosInMiliSec = 0]) async {
    _player.setVolume(0.35);
    await _player.setAsset(url,
        initialPosition: Duration(milliseconds: startPosInMiliSec));
  }

  Future play() async {
    await _player.play();
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
              if (audioSession.androidAudioAttributes?.usage ==
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

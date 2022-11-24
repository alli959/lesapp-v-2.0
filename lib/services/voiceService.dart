import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:Lesaforrit/models/total_points.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pbgrpc.dart'
    hide RecognitionConfig, StreamingRecognitionConfig;
import 'dart:async';

import 'package:google_speech/google_speech.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:audio_session/audio_session.dart';

import '../models/voices/quiz_brain_lvlOne_voice.dart';
import '../models/voices/quiz_brain_lvlThree_voice.dart';
import '../models/voices/quiz_brain_lvlTwo_voice.dart';

class VoiceService {
  SpeechToText speech;
  BuildContext context;
  bool hasSpeech = false;
  bool logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = ' ';
  String lastError = ' ';
  String lastStatus = ' ';
  String currentLocaleID = 'is_IS';
  dynamic localeNames = [];
  bool isListening = false;
  bool finalResult = false;
  String question = ' ';
  String nextQuestion = ' ';
  double points = 0;
  List<bool> questionMap = [];
  List<bool> answerMap = [];
  List<String> questionArr = [];
  List<String> answerArr = [];
  AudioPlayer player = AudioPlayer();
  List<Uint8List> audioList = [];

  TotalPoints calc = TotalPoints();
  List<String> base64 = [];

  QuizBrainLvlThreeVoice quizBrainLvlThree = QuizBrainLvlThreeVoice();
  QuizBrainLvlTwoVoice quizBrainLvlTwo = QuizBrainLvlTwoVoice();
  QuizBrainLvlOneVoice quizBrainLvlOne = QuizBrainLvlOneVoice();

  final RecorderStream _recorder = RecorderStream();
  PlayerStream _player = PlayerStream();
  // Stream<StreamingRecognizeResponse> responseStream;
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>> _audioStreamSubscription;
  BehaviorSubject<List<int>> _audioStream;
  RecognitionConfig config;

  bool isSave = true;
  bool isCancel = false;

  AudioSession session;
  VoiceService({@required this.speech, this.context});

  Future speechInit(Function statusListener, Function errorListener,
      [bool isSave = false]) async {
    config = _getConfig();
    this.isSave = isSave;
    try {
      session = await AudioSession.instance;
      await session.configure(AudioSessionConfiguration(
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
      _recorder.initialize();
      _player.initialize();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getExternalStorageDirectory(); // 1
    print("appDocumentsDirectory is $appDocumentsDirectory");
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoaudiofile.wav'; // 3

    return filePath;
  }

  Uint8List saveFile(List<Uint8List> contents, sampleRate) {
    // File recordedFile = File(await getFilePath());
    print("at savefile place");
    // first stop recording
    List<int> data = [];
    for (var i = 0; i < contents.length; i++) {
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

    File deployFile = new File.fromRawPath(header);
    audioList = [];
    // await recordedFile.writeAsBytes(header, flush: true);

    return header;
  }

  // Future saveFile(List<Uint8List> contents) async {
  //   File.fromRawPath(rawPath)
  //   File file = File(await getFilePath()); // 1
  //   List<int> bytlist = [];
  //   for (var i = 0; i < contents.length; i++) {
  //     print("contents[i] is =>>>>> ${contents[i]}");
  //     try {
  //       bytlist.addAll(contents[i]);
  //     } catch (err) {
  //       print("there was an error $err");
  //       throw err;
  //     }
  //   }
  //   await file.writeAsBytes(bytlist); // 2
  // }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      maxAlternatives: 30,
      enableAutomaticPunctuation: false,
      sampleRateHertz: 16000,
      languageCode: 'is-IS');

  Future speechListen(resultListener, Function doneListener) async {
    session.devicesChangedEventStream.listen((event) {
      print('Devices added:   ${event.devicesAdded}');
      print('Devices removed: ${event.devicesRemoved}');
    });
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        print("EVENT BEGIN!!!! WITH TYPE ${event.type}");
        switch (event.type) {
          case AudioInterruptionType.duck:
            // Another app started playing audio and we should duck.
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            // Another app started playing audio and we should pause.
            break;
        }
      } else {
        print("EVENT NOT BEGIN!!!! WITH TYPE ${event.type}");
        switch (event.type) {
          case AudioInterruptionType.duck:
            // The interruption ended and we should unduck.
            break;
          case AudioInterruptionType.pause:
          // The interruption ended and we should resume.
          case AudioInterruptionType.unknown:
            // The interruption ended but we should not resume.
            break;
        }
      }
    });
    print("we are at speech listen");
    // Activate the audio session before playing audio.
    if (await session.setActive(true)) {
      // Now play audio.

      _audioStream = BehaviorSubject<List<int>>();
      _audioStreamSubscription = _recorder.audioStream.listen((event) {
        if (!_audioStream.isClosed) {
          _audioStream.add(event);
          audioList.add(event);
          _player.writeChunk(event);
        } else {
          print("audiostream is closed!!!!");
        }
      });
      print("before recording start status is ${_recorder.status}");
      await _recorder.start();
      print("after recorder start status is ${_recorder.status}");
      final responseStream = speech.streamingRecognize(
          StreamingRecognitionConfig(config: config, interimResults: true),
          _audioStream);
      print("audiostream where isclosed is ${_audioStream.isClosed}");
      recognizing = true;
      try {
        if (!_audioStream.isClosed) {
          responseStream.listen(resultListener,
              onDone: () => doneListener(
                  file: saveFile(audioList, 16000), isCancel: isCancel));
        }
      } catch (err) {
        print("THERE WAS AN ERROR ${err}");
      }
      this.isCancel = false;
    } else {
      print("audiosession not true");
    }
  }

  Future stopRecording({bool isCancel = false}) async {
    print("isCancel in stopeed Recording is ==> $isCancel");
    // await saveFile(audioList, 16000);
    this.isCancel = isCancel;
    if (isCancel || !isSave) {
      audioList = [];
    }
    print("recording stopped");
    await _recorder?.stop();
    await _player?.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    recognizing = false;
  }

  Future reset() async {
    await stopRecording();
    lastWords = ' ';
    lastError = ' ';
    lastStatus = ' ';
    question = ' ';
    nextQuestion = ' ';
    points = 0;
    questionMap = [];
    answerMap = [];
    questionArr = [];
    answerArr = [];
    calc.correct = 0;
    calc.finalPoints = 0.0;
    calc.trys = 0;
  }

  // Future SaveFile() async {
  //   Share.file
  // }
}

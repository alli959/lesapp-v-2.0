import 'package:Lesaforrit/models/quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class Audio {
  String sound1;
  String sound2;
  int whichSound;

  QuizBrain quizBrain = QuizBrain();
  AudioCache playerCache = AudioCache();
  AudioPlayer audioPlayer1 = AudioPlayer();
  AudioPlayer audioPlayer2 = AudioPlayer();

  Future<AudioPlayer> playAsset() async {
    if (whichSound == 1) {
      audioPlayer1 = await playerCache.play(sound1);
      return audioPlayer1;
    } else {
      audioPlayer2 = await playerCache.play(sound2);
      return audioPlayer2;
    }
  }

  void stop() {
    if (whichSound == 1) {
      audioPlayer1.stop();
    } else {
      audioPlayer2.stop();
    }
  }
}

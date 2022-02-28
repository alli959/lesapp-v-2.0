import '../question.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:Lesaforrit/shared/audio.dart';
import '../../services/get_data.dart';

class QuizBrainLvlThreeEasy {
  // Audio audio = Audio();
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();
  AudioPlayer spilari = AudioPlayer();
  int _question1 = 0;
  int _question2 = 0;
  int correct = 0;
  int trys = 0;
  String sound1;
  String sound2;
  int whichSound;
  int stars = 0;
  double finalscore;
  String typeofgame = "sentences";
  String typeofgamedifficulty = "easy";
  GetData getdata = new GetData(typeofgame, typeofgamedifficulty);
}

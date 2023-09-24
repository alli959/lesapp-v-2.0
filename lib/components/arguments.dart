import 'package:Lesaforrit/models/listeners/level_finish_listener.dart';

import '../models/listeners/level_listener.dart';
import '../models/listeners/level_voice_listener.dart';

class LevelVoiceArguments {
  final VoiceGameType gameType;

  LevelVoiceArguments(this.gameType);
}

class LevelArguments {
  final GameType gameType;
  final String selecteddifficulty;
  bool isCap = false;

  LevelArguments(this.gameType, this.selecteddifficulty, this.isCap);
}

class LevelFinishArguments {
  final FinishGameType gameType;
  final double score;

  LevelFinishArguments(this.gameType, this.score);
}

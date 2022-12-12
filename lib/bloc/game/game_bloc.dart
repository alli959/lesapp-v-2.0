import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/listeners/level_voice_listener.dart';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(null);

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    yield* _mapTypeOfGame(event);
  }

  Stream<GameState> _mapTypeOfGame(GameTypeEvent event) async* {
    yield GameLoading();

    VoiceGameType type = event.gameType;
    print("gameType in bloc is => $type");

    yield GameTypeState(gameType: type);
  }
}

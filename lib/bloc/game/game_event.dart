part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GameTypeEvent extends GameEvent {
  final VoiceGameType gameType;

  GameTypeEvent({@required this.gameType});

  @override
  List<Object> get props => [gameType];
}

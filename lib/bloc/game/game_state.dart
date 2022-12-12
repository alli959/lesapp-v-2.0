part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameTypeState extends GameState {
  final VoiceGameType gameType;

  GameTypeState({@required this.gameType});

  @override
  List<Object> get props => [gameType];
}

class GameLoading extends GameState {}

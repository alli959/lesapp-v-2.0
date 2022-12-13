part of 'audio_bloc.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class InitState extends AudioState {
  final VoiceGameType gameType;

  InitState({@required this.gameType});

  @override
  List<Object> get props => [gameType];
}

class GameLoading extends AudioState {}

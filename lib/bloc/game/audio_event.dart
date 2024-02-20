part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends AudioEvent {
  final VoiceGameType gameType;

  InitEvent({required this.gameType});

  @override
  List<Object> get props => [gameType];
}

part of 'voice_bloc.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object> get props => [];
}

class VoiceInitializeEvent extends VoiceEvent {}

class VoiceStartedEvent extends VoiceEvent {}

class VoiceStoppedEvent extends VoiceEvent {}

class DisplayTextEvent extends VoiceEvent {}

class VoiceFailureEvent extends VoiceEvent {
  final String error;

  VoiceFailureEvent({@required this.error});

  @override
  List<Object> get props => [error];
}

class LastWordsEvent extends VoiceEvent {
  final String lastWords;
  final List<SpeechRecognitionWords> alternates;

  LastWordsEvent({@required this.lastWords, @required this.alternates});

  @override
  List<Object> get props => [lastWords, alternates];
}

class VoiceStatusEvent extends VoiceEvent {
  final String lastStatus;

  VoiceStatusEvent({@required this.lastStatus});

  @override
  List<Object> get props => [lastStatus];
}

class SoundLevelEvent extends VoiceEvent {
  final double level;

  SoundLevelEvent({@required this.level});

  @override
  List<Object> get props => [level];
}

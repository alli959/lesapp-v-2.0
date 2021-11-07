part of 'voice_bloc.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object> get props => [];
}

class VoiceInitializeEvent extends VoiceEvent {
  final Function callback;

  VoiceInitializeEvent({@required this.callback});

  @override
  List<Object> get props => [callback];
}

class VoiceStartedEvent extends VoiceEvent {
  final Function callback;

  VoiceStartedEvent({@required this.callback});

  @override
  List<Object> get props => [callback];
}

class VoiceStoppedEvent extends VoiceEvent {}

class DisplayTextEvent extends VoiceEvent {}

class VoiceFailureEvent extends VoiceEvent {
  final String error;

  VoiceFailureEvent({@required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateEvent extends VoiceEvent {
  final String lastWords;
  final List<SpeechRecognitionWords> alternates;
  final bool isListening;

  UpdateEvent({this.lastWords, this.alternates, this.isListening});

  @override
  List<Object> get props => [lastWords, alternates, isListening];
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

class isListeningEvent extends VoiceEvent {
  final bool isListening;

  isListeningEvent({@required this.isListening});

  @override
  List<Object> get props => [isListening];
}

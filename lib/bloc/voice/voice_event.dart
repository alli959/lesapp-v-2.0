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
  final String question;

  UpdateEvent(
      {this.lastWords, this.alternates, this.isListening, this.question});

  @override
  List<Object> get props => [lastWords, alternates, isListening];
}

class FindBestLastWordEvent extends VoiceEvent {
  final String lastWords;
  final List<SpeechRecognitionWords> alternates;
  final String question;

  FindBestLastWordEvent({this.lastWords, this.alternates, this.question});

  @override
  List<Object> get props => [lastWords, alternates];
}

class SoundLevelEvent extends VoiceEvent {
  final double level;

  SoundLevelEvent({@required this.level});

  @override
  List<Object> get props => [level];
}

class NewQuestionEvent extends VoiceEvent {
  final String question;

  NewQuestionEvent({@required this.question});

  @override
  List<Object> get props => [question];
}

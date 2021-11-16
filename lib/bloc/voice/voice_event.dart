part of 'voice_bloc.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object> get props => [];
}

class VoiceInitializeEvent extends VoiceEvent {
  final Function listeningUpdate;

  VoiceInitializeEvent({@required this.listeningUpdate});

  @override
  List<Object> get props => [listeningUpdate];
}

class VoiceStartedEvent extends VoiceEvent {
  final Function listeningUpdate;
  final Function checkAnswer;

  VoiceStartedEvent({@required this.listeningUpdate, this.checkAnswer});

  @override
  List<Object> get props => [listeningUpdate, checkAnswer];
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
  List<Object> get props => [lastWords, alternates, isListening, question];
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

class ScoreKeeperEvent extends VoiceEvent {
  final bool add;
  final bool remove;
  final TotalPoints calc;

  ScoreKeeperEvent({this.add, this.remove, this.calc});

  @override
  List<Object> get props => [add, remove, calc];
}

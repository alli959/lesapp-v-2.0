part of 'voice_bloc.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object> get props => [];
}

class VoiceInitializeEvent extends VoiceEvent {
  final Function statusListener;
  final Function errorListener;

  VoiceInitializeEvent({
    this.statusListener,
    this.errorListener,
  });

  @override
  List<Object> get props => [statusListener, errorListener];
}

class VoiceStartedEvent extends VoiceEvent {
  final Function resultListener;
  final Function soundLevelListener;

  VoiceStartedEvent({this.resultListener, this.soundLevelListener});

  @override
  List<Object> get props => [resultListener, soundLevelListener];
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
  final bool onePoint;
  final bool twoPoints;
  final bool threePoints;
  final bool fourPoints;
  final bool fivePoints;

  ScoreKeeperEvent(
      {this.onePoint,
      this.twoPoints,
      this.threePoints,
      this.fourPoints,
      this.fivePoints});

  @override
  List<Object> get props => [
        onePoint,
        twoPoints,
        threePoints,
        fourPoints,
        fivePoints,
      ];
}

class ResetEvent extends VoiceEvent {}

class IsListeningEvent extends VoiceEvent {}

class IsNotListeningEvent extends VoiceEvent {}

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
  final Function doneListener;

  VoiceStartedEvent({this.resultListener, this.doneListener});

  @override
  List<Object> get props => [resultListener, doneListener];
}

class VoiceStoppedEvent extends VoiceEvent {}

class VoiceCancelEvent extends VoiceEvent {}

class DisplayTextEvent extends VoiceEvent {}

class VoiceFailureEvent extends VoiceEvent {
  final String error;

  VoiceFailureEvent({@required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateEvent extends VoiceEvent {
  final String lastWords;
  final List<SpeechRecognitionAlternative> alternates;
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

  String username;

  /// Correct, Incorrect, Manual_Correct, Manual_Incorrect
  String typeoffile;
  String question;
  String answer;
  Uint8List audio;
  int trys;
  int correct;

  ScoreKeeperEvent(
      {this.onePoint,
      this.twoPoints,
      this.threePoints,
      this.fourPoints,
      this.fivePoints,
      this.username,
      this.typeoffile,
      this.question,
      this.answer,
      this.audio,
      this.trys,
      this.correct});

  @override
  List<Object> get props => [
        onePoint,
        twoPoints,
        threePoints,
        fourPoints,
        fivePoints,
        [username],
        [typeoffile],
        [question],
        [answer],
        [audio],
        [trys],
        [correct],
      ];
}

class ResetEvent extends VoiceEvent {}

class IsListeningEvent extends VoiceEvent {}

class IsNotListeningEvent extends VoiceEvent {}

class SaveFileEvent extends VoiceEvent {}

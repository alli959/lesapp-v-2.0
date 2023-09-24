part of 'voice_bloc.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object> get props => [];
}

class VoiceInitializeEvent extends VoiceEvent {
  final Function statusListener;
  final Function errorListener;
  final AudioSessionService audiosession;

  VoiceInitializeEvent({
    required this.statusListener,
    required this.errorListener,
    required this.audiosession,
  });

  @override
  List<Object> get props => [statusListener, errorListener, audiosession];
}

class VoiceStartedEvent extends VoiceEvent {
  final void Function(StreamingRecognizeResponse) resultListener;
  final void Function() doneListener;

  VoiceStartedEvent({required this.resultListener, required this.doneListener});

  @override
  List<Object> get props => [resultListener, doneListener];
}

class VoiceStoppedEvent extends VoiceEvent {}

class VoiceCancelEvent extends VoiceEvent {}

class DisplayTextEvent extends VoiceEvent {}

class VoiceFailureEvent extends VoiceEvent {
  final String error;

  VoiceFailureEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateEvent extends VoiceEvent {
  final String lastWords;
  final List<SpeechRecognitionAlternative> alternates;
  final bool isListening;
  final String question;

  UpdateEvent(
      {required this.lastWords,
      required this.alternates,
      required this.isListening,
      required this.question});

  @override
  List<Object> get props => [lastWords, alternates, isListening, question];
}

class FindBestLastWordEvent extends VoiceEvent {
  final String lastWords;
  final List<SpeechRecognitionWords> alternates;
  final String question;

  FindBestLastWordEvent(
      {required this.lastWords,
      required this.alternates,
      required this.question});

  @override
  List<Object> get props => [lastWords, alternates];
}

class SoundLevelEvent extends VoiceEvent {
  final double level;

  SoundLevelEvent({required this.level});

  @override
  List<Object> get props => [level];
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
  Uint8List? audio;
  int trys;
  int correct;

  ScoreKeeperEvent(
      {required this.onePoint,
      required this.twoPoints,
      required this.threePoints,
      required this.fourPoints,
      required this.fivePoints,
      required this.username,
      required this.typeoffile,
      required this.question,
      required this.answer,
      this.audio,
      required this.trys,
      required this.correct});

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

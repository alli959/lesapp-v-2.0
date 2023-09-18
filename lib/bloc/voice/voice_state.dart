part of 'voice_bloc.dart';

abstract class VoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class VoiceInitial extends VoiceState {
  bool hasSpeech = false;
  bool logEvents = true;
  bool isListening = false;
  double level = 50;
  double minSoundLevel = 10;
  double maxSoundLevel = 100;
  String lastWords = "";
  List<SpeechRecognitionWords> alternates = [];
  String lastError = "";
  String lastStatus = "";
  String currentLocaleId = "";
  List<LocaleName> localeNames = [];

  VoiceInitial(
      {hasSpeech,
      logEvents,
      isListening,
      level,
      minSoundLevel,
      maxSoundLevel,
      lastWords,
      alternates,
      lastError,
      lastStatus,
      currentLocaleId,
      localeNames});

  @override
  List<Object> get props => [
        hasSpeech,
        logEvents,
        isListening,
        level,
        minSoundLevel,
        maxSoundLevel,
        lastWords,
        alternates,
        lastError,
        lastStatus,
        currentLocaleId,
        localeNames
      ];
}

class VoiceLanguage extends VoiceState {
  final String currentLocaleId;

  VoiceLanguage({required this.currentLocaleId});

  @override
  List<Object> get props => [currentLocaleId];
}

class VoiceLoading extends VoiceState {}

class VoiceUnitialized extends VoiceState {}

class VoiceHasInitialized extends VoiceState {}

class VoiceStart extends VoiceState {
  final bool isListening;

  VoiceStart({required this.isListening});

  @override
  List<Object> get props => [isListening];
}

class VoiceStop extends VoiceState {
  final bool isCancel;

  VoiceStop({required this.isCancel});

  @override
  List<Object> get props => [isCancel];
}

class VoiceCancel extends VoiceState {}

class UpdateState extends VoiceState {
  final String lastWords;
  final List<SpeechRecognitionAlternative> alternates;
  final String question;
  final bool isListening;

  UpdateState(
      {required this.lastWords,
      required this.alternates,
      required this.question,
      required this.isListening});
  @override
  List<Object> get props => [lastWords, alternates, question, isListening];
}

class VoiceFailure extends VoiceState {
  final String error;

  VoiceFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class DisplayText extends VoiceState {}

class VoiceStatusState extends VoiceState {
  final String lastStatus;

  VoiceStatusState({required this.lastStatus});

  @override
  List<Object> get props => [lastStatus];
}

class SoundLevelState extends VoiceState {
  final double level;

  SoundLevelState({required this.level});

  @override
  List<Object> get props => [level];
}

class NewVoiceQuestionState extends VoiceState {
  final bool onePoint;
  final bool twoPoints;
  final bool threePoints;
  final bool fourPoints;
  final bool fivePoints;
  final int trys;
  final int correct;

  NewVoiceQuestionState(
      {required this.onePoint,
      required this.twoPoints,
      required this.threePoints,
      required this.fourPoints,
      required this.fivePoints,
      required this.trys,
      required this.correct});

  @override
  List<Object> get props =>
      [onePoint, twoPoints, threePoints, fourPoints, fivePoints, trys, correct];
}

class ShowResultState extends VoiceState {
  ShowResultState();

  @override
  List<Object> get props => [];
}

class ScoreKeeper extends VoiceState {
  final bool onePoint;
  final bool twoPoints;
  final bool threePoints;
  final bool fourPoints;
  final bool fivePoints;

  ScoreKeeper(
      {required this.onePoint,
      required this.twoPoints,
      required this.threePoints,
      required this.fourPoints,
      required this.fivePoints});

  @override
  List<Object> get props =>
      [onePoint, twoPoints, threePoints, fourPoints, fivePoints];
}

class CorrectAnimation extends VoiceState {
  final List<Widget> animation;

  CorrectAnimation({required this.animation});

  @override
  List<Object> get props => [animation];
}

class ResetState extends VoiceState {}

class IsListeningState extends VoiceState {}

class IsNotListeningState extends VoiceState {}

class AnswerCleanedState extends VoiceState {}

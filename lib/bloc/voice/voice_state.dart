part of 'voice_bloc.dart';

abstract class VoiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class VoiceInitial extends VoiceState {
  bool hasSpeech;
  bool logEvents;
  bool isListening;
  double level;
  double minSoundLevel;
  double maxSoundLevel;
  String lastWords;
  List<SpeechRecognitionWords> alternates;
  String lastError;
  String lastStatus;
  String currentLocaleId;
  List<LocaleName> localeNames;

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

  VoiceLanguage({@required this.currentLocaleId});

  @override
  List<Object> get props => [currentLocaleId];
}

class VoiceLoading extends VoiceState {}

class VoiceUnitialized extends VoiceState {}

class VoiceHasInitialized extends VoiceState {}

class VoiceStart extends VoiceState {
  final bool isListening;

  VoiceStart({@required this.isListening});

  @override
  List<Object> get props => [isListening];
}

class VoiceStop extends VoiceState {}

class UpdateState extends VoiceState {
  final String lastWords;
  final List<SpeechRecognitionAlternative> alternates;
  final String question;
  final bool isListening;

  UpdateState(
      {this.lastWords, this.alternates, this.question, this.isListening});
  @override
  List<Object> get props => [lastWords, alternates, question, isListening];
}

class VoiceFailure extends VoiceState {
  final String error;

  VoiceFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class DisplayText extends VoiceState {}

class VoiceStatusState extends VoiceState {
  final String lastStatus;

  VoiceStatusState({@required this.lastStatus});

  @override
  List<Object> get props => [lastStatus];
}

class SoundLevelState extends VoiceState {
  final double level;

  SoundLevelState({@required this.level});

  @override
  List<Object> get props => [level];
}

class NewQuestionState extends VoiceState {
  final bool onePoint;
  final bool twoPoints;
  final bool threePoints;
  final bool fourPoints;
  final bool fivePoints;

  NewQuestionState(
      {this.onePoint,
      this.twoPoints,
      this.threePoints,
      this.fourPoints,
      this.fivePoints});

  @override
  List<Object> get props =>
      [onePoint, twoPoints, threePoints, fourPoints, fivePoints];
}

class ShowResultState extends VoiceState {
  final List<String> questionArr;
  final List<String> answerArr;
  final List<bool> questionMap;
  final List<bool> answerMap;

  ShowResultState(
      {this.questionArr, this.answerArr, this.questionMap, this.answerMap});

  @override
  List<Object> get props => [questionArr, answerArr, questionMap, answerMap];
}

class ScoreKeeper extends VoiceState {
  final bool onePoint;
  final bool twoPoints;
  final bool threePoints;
  final bool fourPoints;
  final bool fivePoints;

  ScoreKeeper(
      {this.onePoint,
      this.twoPoints,
      this.threePoints,
      this.fourPoints,
      this.fivePoints});

  @override
  List<Object> get props =>
      [onePoint, twoPoints, threePoints, fourPoints, fivePoints];
}

class CorrectAnimation extends VoiceState {
  final List<Widget> animation;

  CorrectAnimation({this.animation});

  @override
  List<Object> get props => [animation];
}

class ResetState extends VoiceState {}

class IsListeningState extends VoiceState {}

class IsNotListeningState extends VoiceState {}

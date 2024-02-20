part of 'serverless_bloc.dart';

abstract class ServerlessState extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerlessInitial extends ServerlessState {}

class ServerlessLoading extends ServerlessState {}

class ServerlessFailure extends ServerlessState {}

class PlayGameState extends ServerlessState {}

class ServerlessFetch extends ServerlessState {
  final List<Question> questionBank;
  Function? difficulty;

  ServerlessFetch({required this.questionBank, this.difficulty});

  @override
  List<Object> get props => [
        questionBank,
      ];
}

class CheckAnswerState extends ServerlessState {
  final bool upperImageCorrect;
  final bool lowerImageCorrect;
  final bool lowerImageIncorrect;
  final bool upperImageIncorrect;

  CheckAnswerState(
      {required this.upperImageCorrect,
      required this.lowerImageCorrect,
      required this.lowerImageIncorrect,
      required this.upperImageIncorrect});
}

class NewQuestionState extends ServerlessState {
  final bool wasCorrect;

  NewQuestionState({required this.wasCorrect});
}

class DifficultySet extends ServerlessState {}

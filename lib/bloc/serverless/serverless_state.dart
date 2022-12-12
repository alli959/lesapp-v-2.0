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
  Function difficulty;

  ServerlessFetch({@required this.questionBank, difficulty});

  @override
  List<Object> get props => [questionBank, difficulty];
}

class CheckAnswerState extends ServerlessState {
  final bool upperImageCorrect;
  final bool lowerImageCorrect;
  final bool lowerImageIncorrect;
  final bool upperImageIncorrect;

  CheckAnswerState(
      {this.upperImageCorrect,
      this.lowerImageCorrect,
      this.lowerImageIncorrect,
      this.upperImageIncorrect});
}

class NewQuestionState extends ServerlessState {
  final bool wasCorrect;

  NewQuestionState({this.wasCorrect});
}

part of 'serverless_bloc.dart';

abstract class ServerlessEvent extends Equatable {
  const ServerlessEvent();

  @override
  List<Object> get props => [];
}

class PlayGameEvent extends ServerlessEvent {}

class FetchEvent extends ServerlessEvent {
  Future<PrefVoice> prefvoice;
  Function difficulty = () => {};

  FetchEvent({required this.prefvoice, required this.difficulty});

  @override
  List<Object> get props => [prefvoice, difficulty];
}

class CheckAnswerEvent extends ServerlessEvent {
  final bool userAnswer;
  final bool correctAnswer;
  CheckAnswerEvent({required this.userAnswer, required this.correctAnswer});
}

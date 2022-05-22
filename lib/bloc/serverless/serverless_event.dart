part of 'serverless_bloc.dart';

abstract class ServerlessEvent extends Equatable {
  const ServerlessEvent();

  @override
  List<Object> get props => [];
}

class PlayGameEvent extends ServerlessEvent {}

class FetchEvent extends ServerlessEvent {
  Future<PrefVoice> prefvoice;

  FetchEvent({this.prefvoice});

  @override
  List<Object> get props => [prefvoice];
}

class CheckAnswerEvent extends ServerlessEvent {
  final bool userAnswer;
  final bool correctAnswer;
  CheckAnswerEvent({this.userAnswer, this.correctAnswer});
}

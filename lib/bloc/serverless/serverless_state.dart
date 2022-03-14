part of 'serverless_bloc.dart';

abstract class ServerlessState extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerlessInitial extends ServerlessState {}

class ServerlessLoading extends ServerlessState {}

class ServerlessFailure extends ServerlessState {}

class ServerlessFetch extends ServerlessState {
  final List<Question> questionBank;

  ServerlessFetch({@required this.questionBank});

  @override
  List<Object> get props => [questionBank];
}

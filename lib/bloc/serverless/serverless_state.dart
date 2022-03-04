part of 'serverless_bloc.dart';

abstract class ServerlessState extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerlessInitial extends ServerlessState {}

class ServerlessLoading extends ServerlessState {}

class ServerlessFailure extends ServerlessState {}

class ServerlessFetch extends ServerlessState {
  String typeofgame = "sentences";
  String typeofgamedifficulty = "easy";

  ServerlessFetch({@required this.typeofgame, this.typeofgamedifficulty});

  @override
  List<Object> get props => [typeofgame, typeofgamedifficulty];
}

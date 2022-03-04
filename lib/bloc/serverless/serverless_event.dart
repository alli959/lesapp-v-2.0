part of 'serverless_bloc.dart';

abstract class ServerlessEvent extends Equatable {
  const ServerlessEvent();

  @override
  List<Object> get props => [];
}

class FetchEvent extends ServerlessEvent {
  String typeofgame = "sentences";
  String typeofgamedifficulty = "easy";

  FetchEvent({@required this.typeofgame, this.typeofgamedifficulty});

  @override
  List<Object> get props => [typeofgame, typeofgamedifficulty];
}

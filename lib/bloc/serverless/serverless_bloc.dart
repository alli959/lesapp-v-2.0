import 'dart:html';

import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:meta/meta.dart';

part 'serverless_event.dart';
part 'serverless_state.dart';

class ServerlessBloc extends Bloc<ServerlessEvent, ServerlessState> {
  final String _typeOfGame;
  final String _typeofdifficulty;
  ServerlessBloc(String typeOfGame, String typeofdifficulty)
      : assert(typeOfGame != null),
        _typeOfGame = typeOfGame,
        _typeofdifficulty = typeofdifficulty
        super(ServerlessInitial());

  @override
  Stream<ServerlessState> mapEventToState(ServerlessEvent event) async* {
    if (event is ServerlessFetch) {
      yield* _mapFetchData(event);
    }
  }


  Stream<ServerlessState> _mapFetchData(FetchEvent event) async* {
    yield ServerlessLoading();
    


  }
}

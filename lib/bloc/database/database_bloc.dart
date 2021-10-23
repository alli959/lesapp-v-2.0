import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:meta/meta.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseService _databaseService;
  DatabaseBloc(DatabaseService databaseService)
      : assert(databaseService != null),
        _databaseService = databaseService,
        super(DatabaseInitial());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is UpdateUserData) {
      yield* _mapUpdateUserDataToState(event);
    }
    if (event is UpdateUserScore) {
      yield* _mapUpdateUserScoreToState(event);
    }
  }

  Stream<DatabaseState> _mapUpdateUserDataToState(UpdateUserData event) async* {
    yield DatabaseLoading();

    try {
      dynamic userData = await _databaseService.updateUserData(
          event.name,
          event.score,
          event.scoreCaps,
          event.age,
          event.readingStage,
          event.scoreTwo,
          event.scoreTwoLong,
          event.scoreThree,
          event.scoreThreeLong);

      if (userData != null) {
        yield UserDataUpdate(userData: userData);
      }
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapUpdateUserScoreToState(
      UpdateUserScore event) async* {
    yield DatabaseLoading();

    try {
      dynamic userData = await _databaseService.updateUserScore(event.score);

      if (userData != null) {
        yield UserScoreUpdate(userData: userData);
      }
    } catch (e) {
      yield DatabaseFailure();
    }
  }
}

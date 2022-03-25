import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/read.dart';

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
    if (event is GetUserData) {
      yield* _mapUserDataToState(event);
    }
    if (event is GetUsers) {
      yield* _mapUsersToState(event);
    }
  }

  Stream<DatabaseState> _mapUpdateUserDataToState(UpdateUserData event) async* {
    yield DatabaseLoading();

    try {
      dynamic userData = await _databaseService.updateUserData(
          event.name,
          event.age,
          event.readingStage,
          event.lvlOneCapsScore,
          event.lvlOneScore,
          event.lvlOneVoiceScore,
          event.lvlThreeEasyScore,
          event.lvlThreeMediumScore,
          event.lvlThreeVoiceScore,
          event.lvlTwoEasyScore,
          event.lvlTwoMediumScore,
          event.lvlTwoVoiceScore);

      if (userData != null) {
        yield UserDataUpdate(userData: userData);
      }
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapUpdateUserScoreToState(
      UpdateUserScore event) async* {
    print("score in bloc is ${event.score}");
    yield DatabaseLoading();

    try {
      await _databaseService.updateUserScore(event.score, event.typeof);

      Stream<UserData> userData = _databaseService.userData;
      yield UserScoreUpdate(userData: userData);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapUserDataToState(GetUserData event) async* {
    yield DatabaseLoading();

    try {
      Stream<UserData> userData = _databaseService.userData;
      yield UserDataState(userdata: userData);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapUsersToState(GetUsers event) async* {
    yield DatabaseLoading();
    try {
      Stream<List<Read>> users = DatabaseService().users;
      yield UsersState(users: users);
    } catch (e) {
      yield DatabaseFailure();
    }
  }
}

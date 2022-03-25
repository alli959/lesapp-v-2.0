part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class UserDataUpdate extends DatabaseState {
  final UserData userData;

  UserDataUpdate({@required this.userData});

  @override
  List<Object> get props => [userData];
}

class UserScoreUpdate extends DatabaseState {
  final Stream<UserData> userData;

  UserScoreUpdate({@required this.userData});

  @override
  List<Object> get props => [userData];
}

class DatabaseUnitialized extends DatabaseState {}

class DatabaseLoading extends DatabaseState {}

class DatabaseFailure extends DatabaseState {}

class UserDataState extends DatabaseState {
  final Stream<UserData> userdata;

  UserDataState({@required this.userdata});

  @override
  List<Object> get props => [userdata];
}

class UsersState extends DatabaseState {
  final Stream<List<Read>> users;

  UsersState({@required this.users});

  @override
  List<Object> get props => [users];
}

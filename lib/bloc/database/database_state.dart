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
  final UserData userdata;
  final UserScore userscore;

  UserDataState({@required this.userdata, this.userscore});

  @override
  List<Object> get props => [userdata, userscore];
}

class UsersState extends DatabaseState {
  final Stream<List<Read>> users;

  UsersState({@required this.users});

  @override
  List<Object> get props => [users];
}

class SpecialDataState extends DatabaseState {
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  SpecialDataState(
      {@required this.prefVoice,
      @required this.saveRecord,
      @required this.manualFix});

  @override
  List<Object> get props => [prefVoice, saveRecord, manualFix];
}

class ActionPerformedState extends DatabaseState {
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  ActionPerformedState({this.prefVoice, this.saveRecord, this.manualFix});

  @override
  List<Object> get props => [prefVoice, saveRecord, manualFix];
}

class IsNewRecord extends DatabaseState {
  final bool newRecord;
  final double record;
  IsNewRecord({@required this.newRecord, this.record});

  @override
  List<Object> get props => [newRecord];
}

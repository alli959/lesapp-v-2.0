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
  final String school;

  UserDataState({@required this.userdata, this.userscore, this.school});

  @override
  List<Object> get props => [userdata, userscore, school];
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
  final bool agreement;
  final String schoolname;
  final String classname;
  final String name;
  final String age;
  final List<String> schoolnamelist;
  SpecialDataState(
      {@required this.prefVoice,
      @required this.saveRecord,
      @required this.manualFix,
      @required this.agreement,
      @required this.schoolname,
      @required this.classname,
      @required this.name,
      @required this.age,
      @required this.schoolnamelist});

  @override
  List<Object> get props => [
        prefVoice,
        saveRecord,
        manualFix,
        agreement,
        schoolname,
        classname,
        name,
        age,
        schoolnamelist
      ];
}

class ActionPerformedState extends DatabaseState {
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  final bool agreement;
  final String schoolname;
  final String classname;
  final String name;
  final String age;
  ActionPerformedState(
      {this.prefVoice,
      this.saveRecord,
      this.manualFix,
      this.agreement,
      this.schoolname,
      this.classname,
      this.name,
      this.age});

  @override
  List<Object> get props => [
        prefVoice,
        saveRecord,
        manualFix,
        agreement,
        schoolname,
        classname,
        name,
        age
      ];
}

class IsNewRecord extends DatabaseState {
  final bool newRecord;
  final double record;
  IsNewRecord({@required this.newRecord, this.record});

  @override
  List<Object> get props => [newRecord];
}

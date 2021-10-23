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
  final UserData userData;

  UserScoreUpdate({@required this.userData});

  @override
  List<Object> get props => [userData];
}

class DatabaseUnitialized extends DatabaseState {}

class DatabaseLoading extends DatabaseState {}

class DatabaseFailure extends DatabaseState {}

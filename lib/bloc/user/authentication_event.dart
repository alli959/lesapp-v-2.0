part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class UserLoggedIn extends AuthenticationEvent {
  final Usr usr;

  UserLoggedIn({required this.usr});

  @override
  List<Object> get props => [usr];
}

class UserLoggedOut extends AuthenticationEvent {}

class UserRegister extends AuthenticationEvent {
  final Usr usr;

  UserRegister({required this.usr});

  @override
  List<Object> get props => [usr];
}

class LoginScreenToggle extends AuthenticationEvent {}

class RegisterScreenToggle extends AuthenticationEvent {}

class GetUid extends AuthenticationEvent {}

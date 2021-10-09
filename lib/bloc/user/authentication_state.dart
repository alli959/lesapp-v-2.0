part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginScreen extends AuthenticationState {}

class RegisterScreen extends AuthenticationState {}

class AuthenticationInitialized extends AuthenticationState {}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final Usr usr;

  AuthenticationAuthenticated({@required this.usr});

  @override
  List<Object> get props => [usr];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}

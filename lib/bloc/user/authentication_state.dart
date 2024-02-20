part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

//might add more states later.
class UsrState extends AuthenticationState {
  String uid;

  UsrState({required this.uid});

  @override
  List<Object> get props => [uid];
}

class LoginScreen extends AuthenticationState {}

class RegisterScreen extends AuthenticationState {
  List<Map<String, String>> schools;

  RegisterScreen({required this.schools});

  @override
  List<Object> get props => [schools];
}

class AuthenticationInitialized extends AuthenticationState {}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final Usr usr;

  AuthenticationAuthenticated({required this.usr});

  @override
  List<Object> get props => [usr];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class UserUid extends AuthenticationState {
  final String uid;

  UserUid({required this.uid});

  @override
  List<Object> get props => [
        {uid}
      ];
}

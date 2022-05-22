import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../models/read.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;
  final DatabaseBloc _databaseBloc;
  AuthenticationBloc(AuthService authService, {DatabaseBloc databaseBloc})
      : assert(authService != null),
        _authService = authService,
        _databaseBloc = databaseBloc,
        super(AuthenticationInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserRegister) {
      yield* _mapUserRegisterToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
    if (event is LoginScreenToggle) {
      yield* _mapLoginScreenState(event);
    }
    if (event is GetUid) {
      yield* _mapGetUidToState(event);
    }
    if (event is GetUid) {
      yield* _mapGetUidToState(event);
    }
    if (event is RegisterScreenToggle) {
      yield* _mapRegisterScreenState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      if (!Amplify.isConfigured) {
        await _authService.init();
      }
      bool isLoggedIn = await _authService.isLoggedIn();
      print("isLoggedIn = $isLoggedIn");
      if (isLoggedIn) {
        final uid = await _authService.getCurrentUserID();
        Usr usr = Usr(uid: uid);
        yield UserUid(uid: uid);
        await Future.delayed(Duration(milliseconds: 500));
        yield AuthenticationAuthenticated(usr: usr);
      } else {
        print("current user = null");
        yield AuthenticationUnauthenticated();
        yield LoginScreen();
      }
    } on AmplifyException catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    final uid = await _authService.getCurrentUserID();
    yield UserUid(uid: uid);
    await Future.delayed(Duration(milliseconds: 500));
    yield AuthenticationAuthenticated(usr: event.usr);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await _authService.logOut();
    yield AuthenticationLoading();
    await Future.delayed(Duration(milliseconds: 3000));
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _mapUserRegisterToState(
      UserRegister event) async* {
    final uid = await _authService.getCurrentUserID();
    yield UserUid(uid: uid);
    await Future.delayed(Duration(milliseconds: 500));
    yield AuthenticationAuthenticated(usr: event.usr);
  }

  Stream<AuthenticationState> _mapLoginScreenState(
      LoginScreenToggle event) async* {
    yield LoginScreen();
  }

  Stream<AuthenticationState> _mapRegisterScreenState(
      RegisterScreenToggle event) async* {
    yield RegisterScreen();
  }

  Stream<AuthenticationState> _mapGetUidToState(GetUid event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final uid = await _authService.getCurrentUserID();
        print("UID IS => $uid");
        yield UserUid(uid: uid);
      }
    } on AmplifyException catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }
}

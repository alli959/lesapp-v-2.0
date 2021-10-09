import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;
  bool isLoginScreen;
  AuthenticationBloc(AuthService authService)
      : assert(authService != null),
        _authService = authService,
        isLoginScreen = true,
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
    if (event is RegisterScreenToggle) {
      yield* _mapRegisterScreenState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        yield AuthenticationAuthenticated(usr: currentUser);
      } else {
        yield AuthenticationUnauthenticated();
        yield LoginScreen();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(usr: event.usr);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await _authService.logOut();
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _mapUserRegisterToState(
      UserRegister event) async* {
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
}

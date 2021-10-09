import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/exceptions/authentication_exception.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthService _authService;
  LoginBloc(AuthenticationBloc authenticationBloc, AuthService authService)
      : assert(authenticationBloc != null),
        assert(authService != null),
        _authenticationBloc = authenticationBloc,
        _authService = authService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      dynamic usr = await _authService.signInWithEmailAndPassword(
          event.email, event.password);
      if (usr != null) {
        _authenticationBloc.add(UserLoggedIn(usr: usr));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something wierd happened');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}

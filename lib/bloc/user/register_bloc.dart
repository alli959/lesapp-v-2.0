import 'package:bloc/bloc.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/exceptions/authentication_exception.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthService _authService;
  RegisterBloc(AuthenticationBloc authenticationBloc, AuthService authService)
      : assert(AuthenticationBloc != null),
        assert(authService != null),
        _authenticationBloc = authenticationBloc,
        _authService = authService,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterWithEmailButtonPressed) {
      yield* _mapRegisterWithEmailToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterWithEmailToState(
      RegisterWithEmailButtonPressed event) async* {
    yield RegisterLoading();
    try {
      dynamic usr = await _authService.registerWithEmailAndPassword(
          event.email,
          event.password,
          event.name,
          event.age,
          event.readingStage,
          event.lvlOneCapsScore,
          event.lvlOneScore,
          event.lvlOneVoiceScore,
          event.lvlThreeEasyScore,
          event.lvlThreeMediumScore,
          event.lvlThreeVoiceScore,
          event.lvlTwoEasyScore,
          event.lvlTwoMediumScore,
          event.lvlTwoVoiceScore);

      if (usr != null) {
        _authenticationBloc.add(UserRegister(usr: usr));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something wierd happened');
      }
    } on AuthenticationException catch (e) {
      yield RegisterFailure(error: e.message);
    } catch (err) {
      yield RegisterFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}

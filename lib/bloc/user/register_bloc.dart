import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/exceptions/authentication_exception.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthService _authService;
  RegisterBloc(AuthenticationBloc authenticationBloc, AuthService authService)
      : _authenticationBloc = authenticationBloc,
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
    var schools = await rootBundle.loadString('assets/Schools-reverse.json');
    Map<String, dynamic> schoolsList = json.decode(schools);

    print("schoolsList: " + schoolsList.toString() + "");

    // get the key for the school by school name from schoolsList

    String schoolID = schoolsList[event.school];
    print("schoolID: " + schoolID.toString() + "");

    yield RegisterLoading();
    try {
      dynamic usr = await _authService.registerWithEmailAndPassword(
          event.email,
          event.password,
          event.name,
          event.age,
          schoolID,
          event.classname,
          event.aggreement,
          event.lvlOneCapsScore,
          event.lvlOneScore,
          event.lvlOneVoiceScore,
          event.lvlThreeEasyScore,
          event.lvlThreeMediumScore,
          event.lvlThreeVoiceScore,
          event.lvlThreeVoiceMediumScore,
          event.lvlTwoEasyScore,
          event.lvlTwoMediumScore,
          event.lvlTwoVoiceScore,
          event.lvlTwoVoiceMediumScore);

      if (usr != null) {
        _authenticationBloc.add(UserRegister(usr: usr));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something wierd happened');
      }
    } on AuthenticationException catch (e) {
      print("AuthenticationException: " + e.message);
      yield RegisterFailure(error: "Villa við nýskráningu");
    } on UsernameExistsException catch (e) {
      print("UsernameExistsException: " + e.message);
      yield RegisterFailure(error: "Netfang er nú þegar í notkun");
    } on InvalidPasswordException catch (e) {
      print("InvalidPasswordException: " + e.message);
      yield RegisterFailure(error: "Ógilt lykilorð");
    } on InvalidParameterException catch (e) {
      print("InvalidParameterException: " + e.message);
      yield RegisterFailure(error: "Ógildar upplýsingar");
    } on UserNotFoundException catch (e) {
      print("UserNotFoundException: " + e.message);
      yield RegisterFailure(error: "Notandi fannst ekki");
    } catch (err) {
      if (err is FormatException) {
        yield RegisterFailure(error: err.message);
      } else {
        yield RegisterFailure(error: 'An unknown error occurred');
      }
    }
  }
}

part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterWithEmailButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String age;
  final String school;
  final String classname;
  final bool aggreement;

  final double lvlOneCapsScore = 0.0;
  final double lvlOneScore = 0.0;
  final double lvlOneVoiceScore = 0.0;
  final double lvlThreeEasyScore = 0.0;
  final double lvlThreeMediumScore = 0.0;
  final double lvlThreeVoiceScore = 0.0;
  final double lvlThreeVoiceMediumScore = 0.0;
  final double lvlTwoEasyScore = 0.0;
  final double lvlTwoMediumScore = 0.0;
  final double lvlTwoVoiceScore = 0.0;
  final double lvlTwoVoiceMediumScore = 0.0;

  RegisterWithEmailButtonPressed(
      {required this.email,
      required this.password,
      required this.name,
      required this.age,
      required this.school,
      required this.classname,
      required this.aggreement});

  @override
  List<Object> get props => [
        email,
        password,
        name,
        age,
        school,
        classname,
        aggreement,
        lvlOneCapsScore,
        lvlOneScore,
        lvlOneVoiceScore,
        lvlThreeEasyScore,
        lvlThreeMediumScore,
        lvlThreeVoiceScore,
        lvlThreeVoiceMediumScore,
        lvlTwoEasyScore,
        lvlTwoMediumScore,
        lvlTwoVoiceScore,
        lvlTwoVoiceMediumScore
      ];
}

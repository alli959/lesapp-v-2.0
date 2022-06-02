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
  final String readingStage;
  final double lvlOneCapsScore = 0.0;
  final double lvlOneScore = 0.0;
  final double lvlOneVoiceScore = 0.0;
  final double lvlThreeEasyScore = 0.0;
  final double lvlThreeMediumScore = 0.0;
  final double lvlThreeVoiceScore = 0.0;
  final double lvlTwoEasyScore = 0.0;
  final double lvlTwoMediumScore = 0.0;
  final double lvlTwoVoiceScore = 0.0;

  RegisterWithEmailButtonPressed(
      {@required this.email,
      @required this.password,
      @required this.name,
      @required this.age,
      @required this.readingStage});

  @override
  List<Object> get props => [
        email,
        password,
        name,
        age,
        readingStage,
        lvlOneCapsScore,
        lvlOneScore,
        lvlOneVoiceScore,
        lvlThreeEasyScore,
        lvlThreeMediumScore,
        lvlThreeVoiceScore,
        lvlTwoEasyScore,
        lvlTwoMediumScore,
        lvlTwoVoiceScore,
      ];
}

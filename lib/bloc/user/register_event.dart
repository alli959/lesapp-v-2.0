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
  final String lvlOneCapsScore = '0';
  final String lvlOneScore = '0';
  final String lvlOneVoiceScore = '0';
  final String lvlThreeEasyScore = '0';
  final String lvlThreeMediumScore = '0';
  final String lvlThreeVoiceScore = '0';
  final String lvlTwoEasyScore = '0';
  final String lvlTwoMediumScore = '0';
  final String lvlTwoVoiceScore = '0';

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

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
  final String score = '0';
  final String scoreCaps = '0';
  final String scoreTwo = '0';
  final String scoreTwoLong = '0';
  final String scoreThree = '0';
  final String scoreThreeLong = '0';

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
        score,
        scoreCaps,
        scoreTwo,
        scoreTwoLong,
        scoreThree,
        scoreThreeLong,
      ];
}

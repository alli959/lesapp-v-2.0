part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends DatabaseEvent {
  final String name;
  final String age;
  final String readingStage;
  final String lvlOneCapsScore;
  final String lvlOneScore;
  final String lvlOneVoiceScore;
  final String lvlThreeEasyScore;
  final String lvlThreeMediumScore;
  final String lvlThreeVoiceScore;
  final String lvlTwoEasyScore;
  final String lvlTwoMediumScore;
  final String lvlTwoVoiceScore;
  UpdateUserData(
      {@required this.name,
      @required this.age,
      @required this.readingStage,
      @required this.lvlOneCapsScore,
      @required this.lvlOneScore,
      @required this.lvlOneVoiceScore,
      @required this.lvlThreeEasyScore,
      @required this.lvlThreeMediumScore,
      @required this.lvlThreeVoiceScore,
      @required this.lvlTwoEasyScore,
      @required this.lvlTwoMediumScore,
      @required this.lvlTwoVoiceScore});

  @override
  List<Object> get props => [
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
        lvlTwoVoiceScore
      ];
}

class UpdateUserScore extends DatabaseEvent {
  final String score;
  final String typeof;

  UpdateUserScore({@required this.score, @required this.typeof});

  @override
  List<Object> get props => [score, typeof];
}

class GetUserData extends DatabaseEvent {}

class GetUsers extends DatabaseEvent {}

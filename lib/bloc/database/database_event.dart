part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends DatabaseEvent {
  final String name;
  final String score;
  final String scoreCaps;
  final String age;
  final String readingStage;
  final String scoreTwo;
  final String scoreTwoLong;
  final String scoreThree;
  final String scoreThreeLong;
  UpdateUserData(
      {@required this.name,
      @required this.score,
      @required this.scoreCaps,
      @required this.age,
      @required this.readingStage,
      @required this.scoreTwo,
      @required this.scoreTwoLong,
      @required this.scoreThree,
      @required this.scoreThreeLong});

  @override
  List<Object> get props => [
        name,
        score,
        scoreCaps,
        age,
        readingStage,
        scoreTwo,
        scoreTwoLong,
        scoreThree,
        scoreThreeLong
      ];
}

class UpdateUserScore extends DatabaseEvent {
  final String score;

  UpdateUserScore({@required this.score});

  @override
  List<Object> get props => [score];
}

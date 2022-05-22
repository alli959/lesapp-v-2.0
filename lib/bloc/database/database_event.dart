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
  final double lvlOneCapsScore;
  final double lvlOneScore;
  final double lvlOneVoiceScore;
  final double lvlThreeEasyScore;
  final double lvlThreeMediumScore;
  final double lvlThreeVoiceScore;
  final double lvlTwoEasyScore;
  final double lvlTwoMediumScore;
  final double lvlTwoVoiceScore;
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

class SetUserID extends DatabaseEvent {
  final String Uid;

  SetUserID({
    @required this.Uid,
  });

  @override
  List<Object> get props => [Uid];
}

class UpdateUserScore extends DatabaseEvent {
  final double score;
  final String typeof;

  UpdateUserScore({@required this.score, @required this.typeof});

  @override
  List<Object> get props => [score, typeof];
}

class GetUserData extends DatabaseEvent {}

class GetUsers extends DatabaseEvent {}

class GetSpecialData extends DatabaseEvent {}

class SaveSpecialData extends DatabaseEvent {
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  SaveSpecialData({this.prefVoice, this.saveRecord, this.manualFix});

  @override
  List<Object> get props => [prefVoice, saveRecord, manualFix];
}

class ActionPerformedEvent extends DatabaseEvent {
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  ActionPerformedEvent({this.prefVoice, this.saveRecord, this.manualFix});

  @override
  List<Object> get props => [prefVoice, saveRecord, manualFix];
}

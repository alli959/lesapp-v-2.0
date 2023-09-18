part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends DatabaseEvent {
  final String name;
  final String age;
  final String school;
  final String classname;
  final bool agreement;
  final double lvlOneCapsScore;
  final double lvlOneScore;
  final double lvlOneVoiceScore;
  final double lvlThreeEasyScore;
  final double lvlThreeMediumScore;
  final double lvlThreeVoiceScore;
  final double lvlThreeVoiceMediumScore;
  final double lvlTwoEasyScore;
  final double lvlTwoMediumScore;
  final double lvlTwoVoiceScore;
  final double lvlTwoVoiceMediumScore;
  UpdateUserData(
      {required this.name,
      required this.age,
      required this.school,
      required this.classname,
      required this.agreement,
      required this.lvlOneCapsScore,
      required this.lvlOneScore,
      required this.lvlOneVoiceScore,
      required this.lvlThreeEasyScore,
      required this.lvlThreeMediumScore,
      required this.lvlThreeVoiceScore,
      required this.lvlThreeVoiceMediumScore,
      required this.lvlTwoEasyScore,
      required this.lvlTwoMediumScore,
      required this.lvlTwoVoiceScore,
      required this.lvlTwoVoiceMediumScore});

  @override
  List<Object> get props => [
        name,
        age,
        school,
        classname,
        agreement,
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

class SetUserID extends DatabaseEvent {
  final String Uid;

  SetUserID({
    required this.Uid,
  });

  @override
  List<Object> get props => [Uid];
}

class UpdateUserScore extends DatabaseEvent {
  final double score;
  final String typeof;

  UpdateUserScore({required this.score, required this.typeof});

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
  final bool agreement;
  final String schoolname;
  final String classname;
  final String name;
  final String age;
  SaveSpecialData(
      {required this.prefVoice,
      required this.saveRecord,
      required this.manualFix,
      required this.agreement,
      required this.schoolname,
      required this.classname,
      required this.name,
      required this.age});

  @override
  List<Object> get props => [
        prefVoice,
        saveRecord,
        manualFix,
        agreement,
        schoolname,
        classname,
        name,
        age
      ];
}

class ActionPerformedEvent extends DatabaseEvent {
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  final bool agreement;
  final String schoolname;
  final String classname;
  final String name;
  final String age;
  ActionPerformedEvent(
      {required this.prefVoice,
      required this.saveRecord,
      required this.manualFix,
      required this.agreement,
      required this.schoolname,
      required this.classname,
      required this.name,
      required this.age});

  @override
  List<Object> get props => [
        prefVoice,
        saveRecord,
        manualFix,
        agreement,
        schoolname,
        classname,
        name,
        age
      ];
}
